Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB291F5E2
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2019 15:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbfEONse (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 May 2019 09:48:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46181 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbfEONse (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 May 2019 09:48:34 -0400
Received: by mail-wr1-f68.google.com with SMTP id r7so2736797wrr.13
        for <linux-kselftest@vger.kernel.org>; Wed, 15 May 2019 06:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C8C9qQrgN+nbsH+pjHzl6tlp7Nc6h5TeMF/8muSLzN0=;
        b=bb0wfX8/WrYuGLUAmDRcNpnd3bhxH6w7/sgCZ8Drhn8KHryZFCL75wztrn3JWWAnVM
         R0QfBsa9kVPuPPY8Fl3RqZexz2P73kISAhhEJg2Zjo9RldS3sYnWT3YAgPUYR6zk1OcB
         73vtRKTT1JAauCFk9RwePECbqyDWlwQzdCSck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C8C9qQrgN+nbsH+pjHzl6tlp7Nc6h5TeMF/8muSLzN0=;
        b=XZ8TzedKXWMtIJL2enZpGAtRFyrVOd7+fof/94giVffTi1g3Umzvy7DlLfLP0Ba9dv
         feLMGoU+qP2Kdx1xorM4ukTxqpVSeKsCdNzCoVwSvquAPegtkGCeMnMqvcQqEKjyvUMg
         0RMw7Te26QUfZFf56q/NNT+h5lxohfOmEHE4+iSmBskNStp5YDnv2sa8qjypSwd7yrTD
         N/KcpBTMDwQCNhgtvzBJKJC+Rr5S9jgdgAw3bc+IwggFgGreV6GvSxKxTWOnGwPIvgKj
         m6R10DbiJEEwuKsQFSwUcZer9EL7lBauu2ZqHXw5wSOhSzr1ImYLs431R/CcYVhtvrkM
         Pt3w==
X-Gm-Message-State: APjAAAWSIPXQEZATA3KVbXspDnZTcouOJcMAiOseWbOi22YB8db+fKPU
        j+dCrnwsZK4pLl0tVAhh6xH3Cg==
X-Google-Smtp-Source: APXvYqw5wECdzlZCofc+dCbXApCTq0fMDCETyET6YAJzK0hcDDptniDy4A+BRGyfphuaB3WidJzFwQ==
X-Received: by 2002:adf:cc8d:: with SMTP id p13mr13698244wrj.114.1557928112220;
        Wed, 15 May 2019 06:48:32 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aea35.dynamic.kabel-deutschland.de. [95.90.234.53])
        by smtp.gmail.com with ESMTPSA id v5sm4498506wra.83.2019.05.15.06.48.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 06:48:31 -0700 (PDT)
From:   Krzesimir Nowak <krzesimir@kinvolk.io>
To:     bpf@vger.kernel.org
Cc:     iago@kinvolk.io, alban@kinvolk.io,
        Krzesimir Nowak <krzesimir@kinvolk.io>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrey Ignatov <rdna@fb.com>,
        Jiong Wang <jiong.wang@netronome.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf v1 3/3] selftests/bpf: Avoid a clobbering of errno
Date:   Wed, 15 May 2019 15:47:28 +0200
Message-Id: <20190515134731.12611-4-krzesimir@kinvolk.io>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190515134731.12611-1-krzesimir@kinvolk.io>
References: <20190515134731.12611-1-krzesimir@kinvolk.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Save errno right after bpf_prog_test_run returns, so we later check
the error code actually set by bpf_prog_test_run, not by some libcap
function.

Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
Fixes: 5a8d5209ac022 ("selftests: bpf: add trivial JSET tests")
Signed-off-by: Krzesimir Nowak <krzesimir@kinvolk.io>
---
 tools/testing/selftests/bpf/test_verifier.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index bf0da03f593b..514e17246396 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -818,15 +818,17 @@ static int do_prog_test_run(int fd_prog, bool unpriv, uint32_t expected_val,
 	__u32 size_tmp = sizeof(tmp);
 	uint32_t retval;
 	int err;
+	int saved_errno;
 
 	if (unpriv)
 		set_admin(true);
 	err = bpf_prog_test_run(fd_prog, 1, data, size_data,
 				tmp, &size_tmp, &retval, NULL);
+	saved_errno = errno;
 	if (unpriv)
 		set_admin(false);
 	if (err) {
-		switch (errno) {
+		switch (saved_errno) {
 		case 524/*ENOTSUPP*/:
 			printf("Did not run the program (not supported) ");
 			return 0;
-- 
2.20.1

