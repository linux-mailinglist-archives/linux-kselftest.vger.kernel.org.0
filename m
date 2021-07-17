Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7C33CC3F9
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jul 2021 17:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbhGQPFa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 17 Jul 2021 11:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234466AbhGQPF1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 17 Jul 2021 11:05:27 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF95C06175F
        for <linux-kselftest@vger.kernel.org>; Sat, 17 Jul 2021 08:02:30 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id q18-20020a1ce9120000b02901f259f3a250so7618079wmc.2
        for <linux-kselftest@vger.kernel.org>; Sat, 17 Jul 2021 08:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l/fW6Ru6anXnAwkvQcLa3qgutNps22vOmg4AlDACkgc=;
        b=RJvy1j0vEy4rAt4OTi1ttdy6bQFZh8F5pMZWfFWD8Tq2HcqnQ/6u5ysFur6a7B5b1y
         J5U6SlDzIsOCKmoemQah/A03AD32b7AaBubiwP608hEp/nBs5QB8HAYRmRf9s/PO/+Tb
         wLrvsRLVXdJhfmO/PsBHCEK10J5EFKCOY+KOiKZn6WNBg/lFTd3tg8IWVrmlgIkA7ZDg
         LGBKrzxTuzB7P2VH8RVTPBbGH3+Kotnb7TKKZNyuvRe9eVWIfIr4PCLYneaw1KqndIUu
         6wJfePwHfuqjIoMvQfUlrVYBz1xZ+cvsfaF26TJuvmDg8GfgggzbhpnfSNafdwf7gFAc
         /uPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l/fW6Ru6anXnAwkvQcLa3qgutNps22vOmg4AlDACkgc=;
        b=T8+U/0E28zHl+GEfLpUfwyhkSJyy6LkwcN3e9UKFzIg7aEXLtphbda15+Vkmu4GLUq
         aiCrf7DYPkj57NM2rv2z1aib3VTQKy2nkpIx5KDiQIw1nabinnE++cKXHnfMaFCvOWs5
         u8vMNwySq3KXDD8P7hEtbAm1to1DEPxtKGdMFKP8WqLFpqGgq0GsqGMCMeEX+zcZaajs
         au5ADi6EKz9THkm276xnwPkEcPxW+wje98YGhGTlD4b9OGnH6vwwvM4CXwrSxyXLdzpL
         ecUFVkJ43tc9eG81Ij8vnEXMcOcdTMY4AZHkssl2nHoEQ6yOMaNMkiASt876M4l70hSR
         vpQg==
X-Gm-Message-State: AOAM530fHHTucCrZUVtUob9pWy87D8qsGtNcBMa7aYZse92mfOo7HbzI
        tFWvBUyLyAkc+UUm4fjhuygQ3w==
X-Google-Smtp-Source: ABdhPJw9p9mcEEDupLE/IFMse+0PxHZiaXWyCvVilhbnUE++e3ZdhqFI3kdQLxTrEN3WlF7fzOyJ+g==
X-Received: by 2002:a05:600c:cc:: with SMTP id u12mr23090735wmm.19.1626534148658;
        Sat, 17 Jul 2021 08:02:28 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id v9sm11372463wml.36.2021.07.17.08.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 08:02:28 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jakub Kicinski <kuba@kernel.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        YueHaibing <yuehaibing@huawei.com>, netdev@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH 2/2] selftests/net/ipsec: Add test for xfrm_spdattr_type_t
Date:   Sat, 17 Jul 2021 16:02:22 +0100
Message-Id: <20210717150222.416329-3-dima@arista.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210717150222.416329-1-dima@arista.com>
References: <20210717150222.416329-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Set hthresh, dump it again and verify thresh.lbits && thresh.rbits.
They are passed as attributes of xfrm_spdattr_type_t, different from
other message attributes that use xfrm_attr_type_t.
Also, test attribute that is bigger than XFRMA_SPD_MAX, currently it
should be silently ignored.

Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/net/ipsec.c | 165 +++++++++++++++++++++++++++-
 1 file changed, 163 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/ipsec.c b/tools/testing/selftests/net/ipsec.c
index f23438d512c5..3d7dde2c321b 100644
--- a/tools/testing/selftests/net/ipsec.c
+++ b/tools/testing/selftests/net/ipsec.c
@@ -484,13 +484,16 @@ enum desc_type {
 	MONITOR_ACQUIRE,
 	EXPIRE_STATE,
 	EXPIRE_POLICY,
+	SPDINFO_ATTRS,
 };
 const char *desc_name[] = {
 	"create tunnel",
 	"alloc spi",
 	"monitor acquire",
 	"expire state",
-	"expire policy"
+	"expire policy",
+	"spdinfo attributes",
+	""
 };
 struct xfrm_desc {
 	enum desc_type	type;
@@ -1593,6 +1596,155 @@ static int xfrm_expire_policy(int xfrm_sock, uint32_t *seq,
 	return ret;
 }
 
+static int xfrm_spdinfo_set_thresh(int xfrm_sock, uint32_t *seq,
+		unsigned thresh4_l, unsigned thresh4_r,
+		unsigned thresh6_l, unsigned thresh6_r,
+		bool add_bad_attr)
+
+{
+	struct {
+		struct nlmsghdr		nh;
+		union {
+			uint32_t	unused;
+			int		error;
+		};
+		char			attrbuf[MAX_PAYLOAD];
+	} req;
+	struct xfrmu_spdhthresh thresh;
+
+	memset(&req, 0, sizeof(req));
+	req.nh.nlmsg_len	= NLMSG_LENGTH(sizeof(req.unused));
+	req.nh.nlmsg_type	= XFRM_MSG_NEWSPDINFO;
+	req.nh.nlmsg_flags	= NLM_F_REQUEST | NLM_F_ACK;
+	req.nh.nlmsg_seq	= (*seq)++;
+
+	thresh.lbits = thresh4_l;
+	thresh.rbits = thresh4_r;
+	if (rtattr_pack(&req.nh, sizeof(req), XFRMA_SPD_IPV4_HTHRESH, &thresh, sizeof(thresh)))
+		return -1;
+
+	thresh.lbits = thresh6_l;
+	thresh.rbits = thresh6_r;
+	if (rtattr_pack(&req.nh, sizeof(req), XFRMA_SPD_IPV6_HTHRESH, &thresh, sizeof(thresh)))
+		return -1;
+
+	if (add_bad_attr) {
+		BUILD_BUG_ON(XFRMA_IF_ID <= XFRMA_SPD_MAX + 1);
+		if (rtattr_pack(&req.nh, sizeof(req), XFRMA_IF_ID, NULL, 0)) {
+			pr_err("adding attribute failed: no space");
+			return -1;
+		}
+	}
+
+	if (send(xfrm_sock, &req, req.nh.nlmsg_len, 0) < 0) {
+		pr_err("send()");
+		return -1;
+	}
+
+	if (recv(xfrm_sock, &req, sizeof(req), 0) < 0) {
+		pr_err("recv()");
+		return -1;
+	} else if (req.nh.nlmsg_type != NLMSG_ERROR) {
+		printk("expected NLMSG_ERROR, got %d", (int)req.nh.nlmsg_type);
+		return -1;
+	}
+
+	if (req.error) {
+		printk("NLMSG_ERROR: %d: %s", req.error, strerror(-req.error));
+		return -1;
+	}
+
+	return 0;
+}
+
+static int xfrm_spdinfo_attrs(int xfrm_sock, uint32_t *seq)
+{
+	struct {
+		struct nlmsghdr			nh;
+		union {
+			uint32_t	unused;
+			int		error;
+		};
+		char			attrbuf[MAX_PAYLOAD];
+	} req;
+
+	if (xfrm_spdinfo_set_thresh(xfrm_sock, seq, 32, 31, 120, 16, false)) {
+		pr_err("Can't set SPD HTHRESH");
+		return KSFT_FAIL;
+	}
+
+	memset(&req, 0, sizeof(req));
+
+	req.nh.nlmsg_len	= NLMSG_LENGTH(sizeof(req.unused));
+	req.nh.nlmsg_type	= XFRM_MSG_GETSPDINFO;
+	req.nh.nlmsg_flags	= NLM_F_REQUEST;
+	req.nh.nlmsg_seq	= (*seq)++;
+	if (send(xfrm_sock, &req, req.nh.nlmsg_len, 0) < 0) {
+		pr_err("send()");
+		return KSFT_FAIL;
+	}
+
+	if (recv(xfrm_sock, &req, sizeof(req), 0) < 0) {
+		pr_err("recv()");
+		return KSFT_FAIL;
+	} else if (req.nh.nlmsg_type == XFRM_MSG_NEWSPDINFO) {
+		size_t len = NLMSG_PAYLOAD(&req.nh, sizeof(req.unused));
+		struct rtattr *attr = (void *)req.attrbuf;
+		int got_thresh = 0;
+
+		for (; RTA_OK(attr, len); attr = RTA_NEXT(attr, len)) {
+			if (attr->rta_type == XFRMA_SPD_IPV4_HTHRESH) {
+				struct xfrmu_spdhthresh *t = RTA_DATA(attr);
+
+				got_thresh++;
+				if (t->lbits != 32 || t->rbits != 31) {
+					pr_err("thresh differ: %u, %u",
+							t->lbits, t->rbits);
+					return KSFT_FAIL;
+				}
+			}
+			if (attr->rta_type == XFRMA_SPD_IPV6_HTHRESH) {
+				struct xfrmu_spdhthresh *t = RTA_DATA(attr);
+
+				got_thresh++;
+				if (t->lbits != 120 || t->rbits != 16) {
+					pr_err("thresh differ: %u, %u",
+							t->lbits, t->rbits);
+					return KSFT_FAIL;
+				}
+			}
+		}
+		if (got_thresh != 2) {
+			pr_err("only %d thresh returned by XFRM_MSG_GETSPDINFO", got_thresh);
+			return KSFT_FAIL;
+		}
+	} else if (req.nh.nlmsg_type != NLMSG_ERROR) {
+		printk("expected NLMSG_ERROR, got %d", (int)req.nh.nlmsg_type);
+		return KSFT_FAIL;
+	} else {
+		printk("NLMSG_ERROR: %d: %s", req.error, strerror(-req.error));
+		return -1;
+	}
+
+	/* Restore the default */
+	if (xfrm_spdinfo_set_thresh(xfrm_sock, seq, 32, 32, 128, 128, false)) {
+		pr_err("Can't restore SPD HTHRESH");
+		return KSFT_FAIL;
+	}
+
+	/*
+	 * At this moment xfrm uses nlmsg_parse_deprecated(), which
+	 * implies NL_VALIDATE_LIBERAL - ignoring attributes with
+	 * (type > maxtype). nla_parse_depricated_strict() would enforce
+	 * it. Or even stricter nla_parse().
+	 * Right now it's not expected to fail, but to be ignored.
+	 */
+	if (xfrm_spdinfo_set_thresh(xfrm_sock, seq, 32, 32, 128, 128, true))
+		return KSFT_PASS;
+
+	return KSFT_PASS;
+}
+
 static int child_serv(int xfrm_sock, uint32_t *seq,
 		unsigned int nr, int cmd_fd, void *buf, struct xfrm_desc *desc)
 {
@@ -1717,6 +1869,9 @@ static int child_f(unsigned int nr, int test_desc_fd, int cmd_fd, void *buf)
 		case EXPIRE_POLICY:
 			ret = xfrm_expire_policy(xfrm_sock, &seq, nr, &desc);
 			break;
+		case SPDINFO_ATTRS:
+			ret = xfrm_spdinfo_attrs(xfrm_sock, &seq);
+			break;
 		default:
 			printk("Unknown desc type %d", desc.type);
 			exit(KSFT_FAIL);
@@ -1994,8 +2149,10 @@ static int write_proto_plan(int fd, int proto)
  *   sizeof(xfrm_user_polexpire)  = 168  |  sizeof(xfrm_user_polexpire)  = 176
  *
  * Check the affected by the UABI difference structures.
+ * Also, check translation for xfrm_set_spdinfo: it has it's own attributes
+ * which needs to be correctly copied, but not translated.
  */
-const unsigned int compat_plan = 4;
+const unsigned int compat_plan = 5;
 static int write_compat_struct_tests(int test_desc_fd)
 {
 	struct xfrm_desc desc = {};
@@ -2019,6 +2176,10 @@ static int write_compat_struct_tests(int test_desc_fd)
 	if (__write_desc(test_desc_fd, &desc))
 		return -1;
 
+	desc.type = SPDINFO_ATTRS;
+	if (__write_desc(test_desc_fd, &desc))
+		return -1;
+
 	return 0;
 }
 
-- 
2.32.0

