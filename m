Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAC279921B
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Sep 2023 00:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245577AbjIHWWs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 18:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjIHWWq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 18:22:46 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6361FC6
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Sep 2023 15:22:42 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7ec535fe42so2297604276.1
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Sep 2023 15:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694211761; x=1694816561; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gYFwNaHOE9Gb8BtRYtg1fi2IuOu5WJ//tLflJpSOuU0=;
        b=UZ4nEodqfUiE1TBBLxRbBE6CGcPF0ZxTlCkl3G295Ma2Qm0QHYaMlTkM1ViwZYLdIr
         EYY25k8et+Igt290cIFcdtSLsFY0imXbDAetEUnI64tOvOs8TG+d47IuVdwHslOlXK5x
         A6OWdh3IkV3Svp3Tb0fIIEKvlh1kqxPJLcoGyBYC8lHKQt8X5rDHYRJ/YzgAKV3OuM9q
         AVsVPzDeQ7aR8e0T16d9eOq9JS4wDxXxeyh9lGYt5SrHFVwF3UB7WJAn7+h4Pm4Uw5BA
         rVrQnFKWtpt95j/90VRxn/YA2XLaH9YIAAarasjREu3HHOm5LQ5lu1eHxXF6ZK6S9lmB
         gt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694211761; x=1694816561;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gYFwNaHOE9Gb8BtRYtg1fi2IuOu5WJ//tLflJpSOuU0=;
        b=C6YEr5+PkDYguHPjGj6/JMe5M7gnAnTbJBuvpZW1bdSaepKGw0lyup7eiUWRqlvXVc
         nBytvivJLPVEv8B2JoQ+KSkWvuC2hn1mI5TkUJVLrVhLQOZZIx5jJnPkbthFUjzxjT8r
         1DOQFT+MDy4/ZJ09ihCtNsBIdoUWlJBNU01XNIALVEOQld28pHa3CkJMHGJcHx8g1B7y
         w3J+vKN0pBkuLANMFJ2+91L6/7fsofVlQzn3yoL9h1pYjrH/oW7BDmlk+A9BSXnJT0mu
         o7D/EKL3aHeYUYO54KaIPcF6sgyLq9o2ftGnldSvw3RTwctNiXSdi/k9rm0UJD2fvlTq
         RQXA==
X-Gm-Message-State: AOJu0YwxaFV7jgneZQyNko2pICCHdAz6cPUc6kagL1ouSMATLXV3wpX/
        QRnkaE+2pramUvwjthdY5TYUbb8YcYCecxzbOA==
X-Google-Smtp-Source: AGHT+IH/dZif8ZNBOT7oK04Qr/HSa5OvHNQCkN8TzxXe3Xwr0uD+zxocLyl7KL/gWADq0/EydxN0bn9uGbXKo2GMDw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:77d7:0:b0:d7e:afff:c8fa with SMTP
 id s206-20020a2577d7000000b00d7eafffc8famr91028ybc.5.1694211761764; Fri, 08
 Sep 2023 15:22:41 -0700 (PDT)
Date:   Fri, 08 Sep 2023 22:22:37 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAK2e+2QC/x3MTQqAIBBA4avErBPEtL+rRAvRsYaiwpEIpLsnL
 b/FexkYIyHDWGWIeBPTeRSougK32mNBQb4YlFSNHGQvNsY9JOQk5CCKTeu7oG3vjdNQqitioOc /TvP7fpelbF9hAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694211760; l=2010;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=DkdXz0gdYc8K4Dds4Hy2YgaRuE3mMLNMc2Nv2KtHoLM=; b=hfjA+lh2yDSa1Epz8BoB10kB7nRgp5rdqEjyTIW3oK3cbxeqC4ESVF7raHoM5rRrg0bOLhF2X
 RObNw/URLUtDwIm23oF2u119UfojLMeap0Qrevubi71IG/gdDhQis6C
X-Mailer: b4 0.12.3
Message-ID: <20230908-kselftest-09-08-v2-0-0def978a4c1b@google.com>
Subject: [PATCH v2 0/3] selftests/hid: fix building for older kernels
From:   Justin Stitt <justinstitt@google.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Eduard Zingerman <eddyz87@gmail.com>, linux-input@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, I am sending this series on behalf of myself and Benjamin Tissoires. There
existed an initial n=3 patch series which was later expanded to n=4 and
is now back to n=3 with some fixes added in and rebased against
mainline.

This patch series aims to ensure that the hid/bpf selftests can be built
without errors.

Here's Benjamin's initial cover letter for context:
|  These fixes have been triggered by [0]:
|  basically, if you do not recompile the kernel first, and are
|  running on an old kernel, vmlinux.h doesn't have the required
|  symbols and the compilation fails.
|
|  The tests will fail if you run them on that very same machine,
|  of course, but the binary should compile.
|
|  And while I was sorting out why it was failing, I realized I
|  could do a couple of improvements on the Makefile.
|
|  [0] https://lore.kernel.org/linux-input/56ba8125-2c6f-a9c9-d498-0ca1c153dcb2@redhat.com/T/#t

Changes from v1 -> v2:
- roll Justin's fix into patch 1/3
- add __attribute__((preserve_access_index)) (thanks Eduard)
- rebased onto mainline (2dde18cd1d8fac735875f2e4987f11817cc0bc2c)
- Link to v1: https://lore.kernel.org/all/20230825-wip-selftests-v1-0-c862769020a8@kernel.org/

Link: https://github.com/ClangBuiltLinux/linux/issues/1698
Link: https://github.com/ClangBuiltLinux/continuous-integration2/issues/61
---
Benjamin Tissoires (3):
      selftests/hid: ensure we can compile the tests on kernels pre-6.3
      selftests/hid: do not manually call headers_install
      selftests/hid: force using our compiled libbpf headers

 tools/testing/selftests/hid/Makefile               | 10 ++---
 tools/testing/selftests/hid/progs/hid.c            |  3 --
 .../testing/selftests/hid/progs/hid_bpf_helpers.h  | 49 ++++++++++++++++++++++
 3 files changed, 53 insertions(+), 9 deletions(-)
---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230908-kselftest-09-08-56d7f4a8d5c4

Best regards,
--
Justin Stitt <justinstitt@google.com>

