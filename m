Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619F7737190
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jun 2023 18:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjFTQap (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Jun 2023 12:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjFTQaj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Jun 2023 12:30:39 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6900D1710
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Jun 2023 09:30:36 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f8f3786f20so57411205e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Jun 2023 09:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687278634; x=1689870634;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bm5QjXe0oZ1sN3o3B7gp+ZfBZHzDUDc+RJQ+ZIqrios=;
        b=OUSg1jgqq3X31GcBAN7S/8B55r8VdE4TVxCN8WmLvW2Kr0zaDb2omj6bhzkqJFboxC
         xV9rHAzs6j6HK6vugT4QcmhWWc47/tYXJcAMpJOdOhuDlRVdO7KLwJa5VLsBCgXKlz2d
         XrosX6SgRGHDgrNvA4eZihNc7viY0xMdHXwEgH5SAS3LhmU9Md4t1C4wfHhdA9oamLg9
         nZCnKpM4X9T/KaJL34KQRXf4wg8SUbpnYDFANKvkqMPWyPxAtb3AH7+JSPay9C3glvXo
         E2n27yo+v4xqAtgRnJnjeJATxtzA08EQvoc3E6V+8IKDOqZUWYTfVpSoBpiTU7R70Qe0
         m2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687278634; x=1689870634;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bm5QjXe0oZ1sN3o3B7gp+ZfBZHzDUDc+RJQ+ZIqrios=;
        b=KCLfxCc8lE34nOZpcTfOYnuQL5rmn9ufsJvIxR+ZF68cPNucxxfmamPgQCpsmirgJe
         Z3fdsThpZjTVzECyUI0w4XOb4mjxMl6YY0oxgXimEVaIAbVqadCGpbiggdxPBXPX1AWZ
         zJm3avzaRCyTTgHs1CLNIwzZtMOlhTMPhswCUlDqAYXzrIy9Zo/huf8HM8wNgHhfcTIe
         rUNnOhOTHNWl/NV3DSl85Jy2s6jhFIBcHlDZ4YEWesBsFdOAzf4j/a9APMgk2VPq462/
         YFaizjCcRKF/6nW1bnCybM1R8n+Yp7jeaSVnL11EH3QuWfjkUcj+RzfQrSqUkulUpgS/
         tLuQ==
X-Gm-Message-State: AC+VfDydgp3s/NFwUxr5talWGEQu5VCQm9GI1EZ8MfMl9D1nfjib4OFP
        aF8Z0wRccjPN1dUjN8K32SCv/w==
X-Google-Smtp-Source: ACHHUZ402qZAPIQBLf0B/A1jPHKfPkA2UkdjJp5hoiuV7UKm5VufPf++rAVX4lfezV4ji54nSvz//Q==
X-Received: by 2002:a7b:c412:0:b0:3f9:b58:df5e with SMTP id k18-20020a7bc412000000b003f90b58df5emr8899695wmi.27.1687278634490;
        Tue, 20 Jun 2023 09:30:34 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id y7-20020a05600c364700b003f8fbe3bf7asm12064342wmq.32.2023.06.20.09.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 09:30:34 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Tue, 20 Jun 2023 18:30:18 +0200
Subject: [PATCH net-next 5/9] mptcp: introduce MPTCP_FULL_INFO getsockopt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-upstream-net-next-20230620-mptcp-expose-more-info-and-misc-v1-5-62b9444bfd48@tessares.net>
References: <20230620-upstream-net-next-20230620-mptcp-expose-more-info-and-misc-v1-0-62b9444bfd48@tessares.net>
In-Reply-To: <20230620-upstream-net-next-20230620-mptcp-expose-more-info-and-misc-v1-0-62b9444bfd48@tessares.net>
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6801;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=o/0+BDl7MSfxpBypAltz5t1ouUesepVQ+7hOMVYbpUA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkkdQk/oUW/NimsARi9wRT/OmCrUQpj1lwskatg
 0bEtZ+fz7yJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJHUJAAKCRD2t4JPQmmg
 c4TOD/9wPj5TyMyEApib57V88k46eTBqZK2HnDn6vjvvSUpGzY/qgNPFrgJn1t5/ymJf/YeOfZm
 c3l/5izYVWlHLBd2x+McgioJhpBlJhXL4685/IUOsXwNLxnBEOYDv+4HWLS5tIS27Okn4hL65uk
 nH8f+R8QvZhKE72Pa4nSB5fOrpbdovIAOCXxl+ftb4CZ9V0n5hotr3A760GuODJwmwWbAnqItXE
 twVw7M/b14qhr2ZzEG2SgsOHQxEJ57c7i73ARrAzmWxiZBgUx50O6+gPTMOQu1FhvhDjzXLjJUm
 y5E/w3pOtIt54ReFwteO83rbTRu0YvMe2Cl2StHt5RPedMNTEzUb/2sdWBWKAXqH9I5Wm1pDKJM
 BjmjrpeeRwTSUw9Atm8LCTYeeoMPyyiAMqeECdt49rwqWBvkE2O3oPz0N9Zgj8CWcxLPXkQUYAI
 b2fL+8Bx7nWUrIGNmnHKkJYbrGfBLCzRHZ5Q4A0QyB+xIsloWpXgVWpxNPFfoHKj/ZGsJfa6sze
 U7LccSvnKtQb0UOC09Kmv8NtPpHoFE/Qfa0s620wQIoUERCnPZqjO0dyrRGk/iDFdZAQ6LmHkb2
 VAixASuJj3AuFBbSgU7BRXxmQuxRxRpm4I2ygQZztVn4Ha7wBNkLAWJIcZssUO1LRUJK6/JaK2H
 3kxl2q0u1S5ZA4Q==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

Some user-space applications want to monitor the subflows utilization.

Dumping the per subflow tcp_info is not enough, as the PM could close
and re-create the subflows under-the-hood, fooling the accounting.
Even checking the src/dst addresses used by each subflow could not
be enough, because new subflows could re-use the same address/port of
the just closed one.

This patch introduces a new socket option, allow dumping all the relevant
information all-at-once (everything, everywhere...), in a consistent
manner.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/388
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 include/uapi/linux/mptcp.h |  24 +++++++++
 net/mptcp/sockopt.c        | 127 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 149 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index a124be6ebbba..ee9c49f949a2 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -249,9 +249,33 @@ struct mptcp_subflow_addrs {
 	};
 };
 
+struct mptcp_subflow_info {
+	__u32				id;
+	struct mptcp_subflow_addrs	addrs;
+};
+
+struct mptcp_full_info {
+	__u32		size_tcpinfo_kernel;	/* must be 0, set by kernel */
+	__u32		size_tcpinfo_user;
+	__u32		size_sfinfo_kernel;	/* must be 0, set by kernel */
+	__u32		size_sfinfo_user;
+	__u32		num_subflows;		/* must be 0, set by kernel (real subflow count) */
+	__u32		size_arrays_user;	/* max subflows that userspace is interested in;
+						 * the buffers at subflow_info/tcp_info
+						 * are respectively at least:
+						 *  size_arrays * size_sfinfo_user
+						 *  size_arrays * size_tcpinfo_user
+						 * bytes wide
+						 */
+	__aligned_u64		subflow_info;
+	__aligned_u64		tcp_info;
+	struct mptcp_info	mptcp_info;
+};
+
 /* MPTCP socket options */
 #define MPTCP_INFO		1
 #define MPTCP_TCPINFO		2
 #define MPTCP_SUBFLOW_ADDRS	3
+#define MPTCP_FULL_INFO		4
 
 #endif /* _UAPI_MPTCP_H */
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index fa5055d5b029..63f7a09335c5 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -14,7 +14,8 @@
 #include <net/mptcp.h>
 #include "protocol.h"
 
-#define MIN_INFO_OPTLEN_SIZE	16
+#define MIN_INFO_OPTLEN_SIZE		16
+#define MIN_FULL_INFO_OPTLEN_SIZE	40
 
 static struct sock *__mptcp_tcp_fallback(struct mptcp_sock *msk)
 {
@@ -981,7 +982,8 @@ static int mptcp_put_subflow_data(struct mptcp_subflow_data *sfd,
 }
 
 static int mptcp_get_subflow_data(struct mptcp_subflow_data *sfd,
-				  char __user *optval, int __user *optlen)
+				  char __user *optval,
+				  int __user *optlen)
 {
 	int len, copylen;
 
@@ -1162,6 +1164,125 @@ static int mptcp_getsockopt_subflow_addrs(struct mptcp_sock *msk, char __user *o
 	return 0;
 }
 
+static int mptcp_get_full_info(struct mptcp_full_info *mfi,
+			       char __user *optval,
+			       int __user *optlen)
+{
+	int len;
+
+	BUILD_BUG_ON(offsetof(struct mptcp_full_info, mptcp_info) !=
+		     MIN_FULL_INFO_OPTLEN_SIZE);
+
+	if (get_user(len, optlen))
+		return -EFAULT;
+
+	if (len < MIN_FULL_INFO_OPTLEN_SIZE)
+		return -EINVAL;
+
+	memset(mfi, 0, sizeof(*mfi));
+	if (copy_from_user(mfi, optval, MIN_FULL_INFO_OPTLEN_SIZE))
+		return -EFAULT;
+
+	if (mfi->size_tcpinfo_kernel ||
+	    mfi->size_sfinfo_kernel ||
+	    mfi->num_subflows)
+		return -EINVAL;
+
+	if (mfi->size_sfinfo_user > INT_MAX ||
+	    mfi->size_tcpinfo_user > INT_MAX)
+		return -EINVAL;
+
+	return len - MIN_FULL_INFO_OPTLEN_SIZE;
+}
+
+static int mptcp_put_full_info(struct mptcp_full_info *mfi,
+			       char __user *optval,
+			       u32 copylen,
+			       int __user *optlen)
+{
+	copylen += MIN_FULL_INFO_OPTLEN_SIZE;
+	if (put_user(copylen, optlen))
+		return -EFAULT;
+
+	if (copy_to_user(optval, mfi, copylen))
+		return -EFAULT;
+	return 0;
+}
+
+static int mptcp_getsockopt_full_info(struct mptcp_sock *msk, char __user *optval,
+				      int __user *optlen)
+{
+	unsigned int sfcount = 0, copylen = 0;
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	void __user *tcpinfoptr, *sfinfoptr;
+	struct mptcp_full_info mfi;
+	int len;
+
+	len = mptcp_get_full_info(&mfi, optval, optlen);
+	if (len < 0)
+		return len;
+
+	/* don't bother filling the mptcp info if there is not enough
+	 * user-space-provided storage
+	 */
+	if (len > 0) {
+		mptcp_diag_fill_info(msk, &mfi.mptcp_info);
+		copylen += min_t(unsigned int, len, sizeof(struct mptcp_info));
+	}
+
+	mfi.size_tcpinfo_kernel = sizeof(struct tcp_info);
+	mfi.size_tcpinfo_user = min_t(unsigned int, mfi.size_tcpinfo_user,
+				      sizeof(struct tcp_info));
+	sfinfoptr = u64_to_user_ptr(mfi.subflow_info);
+	mfi.size_sfinfo_kernel = sizeof(struct mptcp_subflow_info);
+	mfi.size_sfinfo_user = min_t(unsigned int, mfi.size_sfinfo_user,
+				     sizeof(struct mptcp_subflow_info));
+	tcpinfoptr = u64_to_user_ptr(mfi.tcp_info);
+
+	lock_sock(sk);
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		struct mptcp_subflow_info sfinfo;
+		struct tcp_info tcp_info;
+
+		if (sfcount++ >= mfi.size_arrays_user)
+			continue;
+
+		/* fetch addr/tcp_info only if the user space buffers
+		 * are wide enough
+		 */
+		memset(&sfinfo, 0, sizeof(sfinfo));
+		sfinfo.id = subflow->subflow_id;
+		if (mfi.size_sfinfo_user >
+		    offsetof(struct mptcp_subflow_info, addrs))
+			mptcp_get_sub_addrs(ssk, &sfinfo.addrs);
+		if (copy_to_user(sfinfoptr, &sfinfo, mfi.size_sfinfo_user))
+			goto fail_release;
+
+		if (mfi.size_tcpinfo_user) {
+			tcp_get_info(ssk, &tcp_info);
+			if (copy_to_user(tcpinfoptr, &tcp_info,
+					 mfi.size_tcpinfo_user))
+				goto fail_release;
+		}
+
+		tcpinfoptr += mfi.size_tcpinfo_user;
+		sfinfoptr += mfi.size_sfinfo_user;
+	}
+	release_sock(sk);
+
+	mfi.num_subflows = sfcount;
+	if (mptcp_put_full_info(&mfi, optval, copylen, optlen))
+		return -EFAULT;
+
+	return 0;
+
+fail_release:
+	release_sock(sk);
+	return -EFAULT;
+}
+
 static int mptcp_put_int_option(struct mptcp_sock *msk, char __user *optval,
 				int __user *optlen, int val)
 {
@@ -1235,6 +1356,8 @@ static int mptcp_getsockopt_sol_mptcp(struct mptcp_sock *msk, int optname,
 	switch (optname) {
 	case MPTCP_INFO:
 		return mptcp_getsockopt_info(msk, optval, optlen);
+	case MPTCP_FULL_INFO:
+		return mptcp_getsockopt_full_info(msk, optval, optlen);
 	case MPTCP_TCPINFO:
 		return mptcp_getsockopt_tcpinfo(msk, optval, optlen);
 	case MPTCP_SUBFLOW_ADDRS:

-- 
2.40.1

