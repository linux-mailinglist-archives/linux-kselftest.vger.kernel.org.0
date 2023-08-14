Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBB577B45C
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 10:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbjHNIly (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 04:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbjHNIls (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 04:41:48 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050:0:465::202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3927127;
        Mon, 14 Aug 2023 01:41:45 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RPSYd70PJz9slh;
        Mon, 14 Aug 2023 10:41:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
        t=1692002502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=79RoJoR/fwEl868XiYEwCuZo1mWc1anAic2p8X8NglE=;
        b=p1mH3+eN9eCVXdi/TxEUdL6OIDyTpQYTMvtKaZZl79SDtqiMak9oJhVRBoeaG94oNA8btJ
        PXKhAtBfpm7RHIgirGHwamL0Dqr5iJzMUBPRM7gjZR47hIhN/BQmCcoL7ufFIkmwRd7HqN
        mVSznBoc06lgSX95l1aKE8O5Iqd0oGrgrweoODmiJ5QxpRealAixDosNM60Yo40IYyHmgg
        UYfjbMmbOD9Hz5BIR3vTbMmxgQcmoaVDW7Tiy9rJ0hv/5isMvaFDnVF17zljfHsxF5j7Ls
        UyjsKXdyA9wOQ660D6kuX8HSkD2lACAmd416Q3kl9z/0UdxSYT4GZVOm+puhqA==
From:   Aleksa Sarai <cyphar@cyphar.com>
Date:   Mon, 14 Aug 2023 18:40:59 +1000
Subject: [PATCH v2 3/5] memfd: improve userspace warnings for missing
 exec-related flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230814-memfd-vm-noexec-uapi-fixes-v2-3-7ff9e3e10ba6@cyphar.com>
References: <20230814-memfd-vm-noexec-uapi-fixes-v2-0-7ff9e3e10ba6@cyphar.com>
In-Reply-To: <20230814-memfd-vm-noexec-uapi-fixes-v2-0-7ff9e3e10ba6@cyphar.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Jeff Xu <jeffxu@google.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        stable@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2138; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=RhSvSYmzoCDTkzH6eBS7S4EFPaKzfTKNkGx9zoaFDXg=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaTcfLHKkqnzauO+Q1m9W/cV6QoIafZdM/7bxXw//nBq8
 PzZ8dumdpSyMIhxMciKKbJs8/MM3TR/8ZXkTyvZYOawMoEMYeDiFICJPFNl+F/zy9EjaynTW+l7
 ofv84tUT6+bn3924QbCv9tcRc+nsOj5GhjfxJfaqHXPWTy+PW/w4KtRJ8Llqn1Da/fm3D9eIrua
 pYQcA
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4RPSYd70PJz9slh
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In order to incentivise userspace to switch to passing MFD_EXEC and
MFD_NOEXEC_SEAL, we need to provide a warning on each attempt to call
memfd_create() without the new flags. pr_warn_once() is not useful
because on most systems the one warning is burned up during the boot
process (on my system, systemd does this within the first second of
boot) and thus userspace will in practice never see the warnings to push
them to switch to the new flags.

The original patchset[1] used pr_warn_ratelimited(), however there were
concerns about the degree of spam in the kernel log[2,3]. The resulting
inability to detect every case was flagged as an issue at the time[4].

While we could come up with an alternative rate-limiting scheme such as
only outputting the message if vm.memfd_noexec has been modified, or
only outputting the message once for a given task, these alternatives
have downsides that don't make sense given how low-stakes a single
kernel warning message is. Switching to pr_info_ratelimited() instead
should be fine -- it's possible some monitoring tool will be unhappy
with a stream of warning-level messages but there's already plenty of
info-level message spam in dmesg.

[1]: https://lore.kernel.org/20221215001205.51969-4-jeffxu@google.com/
[2]: https://lore.kernel.org/202212161233.85C9783FB@keescook/
[3]: https://lore.kernel.org/Y5yS8wCnuYGLHMj4@x1n/
[4]: https://lore.kernel.org/f185bb42-b29c-977e-312e-3349eea15383@linuxfoundation.org/

Cc: stable@vger.kernel.org # v6.3+
Fixes: 105ff5339f49 ("mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC")
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 mm/memfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memfd.c b/mm/memfd.c
index d65485c762de..aa46521057ab 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -315,7 +315,7 @@ SYSCALL_DEFINE2(memfd_create,
 		return -EINVAL;
 
 	if (!(flags & (MFD_EXEC | MFD_NOEXEC_SEAL))) {
-		pr_warn_once(
+		pr_info_ratelimited(
 			"%s[%d]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set\n",
 			current->comm, task_pid_nr(current));
 	}

-- 
2.41.0

