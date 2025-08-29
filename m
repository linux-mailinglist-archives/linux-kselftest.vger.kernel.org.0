Return-Path: <linux-kselftest+bounces-40340-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0598B3C316
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 21:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 069C7A28588
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 19:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5526248F72;
	Fri, 29 Aug 2025 19:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NmUET5/X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEFD242D7B
	for <linux-kselftest@vger.kernel.org>; Fri, 29 Aug 2025 19:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756496039; cv=none; b=FTretGTdPmw/SiEDRz0Gag9bcMbxI0QolN+eTmPxgv0m9pe0assb0TfRNzdu093G/j0L8FI9lm48J4iOUf6ONVemyI6A3tKf3FRK3lQFVK1n9Mrv1+m+9LF97qKGRLGVliXWxSwI2RlU5dI6aA6MY5n6o9qDjTpiRj3Hvlwokf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756496039; c=relaxed/simple;
	bh=OArcrcPJKctf7kyzhyu5N9o4Z5m1mtDS835/OiICaDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CNS+Pfe5KZu0OtD7BFztwV0qFSyu3WjMPm1kyUIlqTCMl8400KsYqc4o+Z3WOQnPB4+9Q+zMUoIiglok9Lh1FSIHFRe8scvuPBztFu3HuJbCxR5aixzkp8Ru6zCvOTVlUAJkZyFeTLmjife7fikysiHrIFD/gvy4DZGDjP/fjxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NmUET5/X; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3c6abcfd142so1101714f8f.2
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Aug 2025 12:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756496035; x=1757100835; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=10aYLv6x+nousnJCn+LNWW0LkPPpH+PRdELXD4FgtcI=;
        b=NmUET5/X3U8sj2gncXKyFCnU5CVXnxTD2YGhtvVi8DHQg6+yBIW+pbrP9bCZaDtY9T
         CnRAMaYFNBKYoa1T6b+uRj+omG/LIAvoPUMk1NU3eni5IiBhv0ZbvJCKeLCi5+QQwf1F
         PCF8ayZgHuxI4dE7FRFuNLDvNy6OV2n4mYejFLNVg+p4Cdzj/chxFTxcZ4BPWSVN/Jck
         V1hMFJeTQcHGflCsvCfxLv07pjCWX9p0qZU9MnmFiJ0Ove++lVsi6WW1qf6aGsK9uit/
         zfeqHBfG5PzYsvEefpsBCsCDj/YoZ8omUh0ArMSz0SLlNp2SB97cKo6B1EraCdW5regL
         F0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756496035; x=1757100835;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=10aYLv6x+nousnJCn+LNWW0LkPPpH+PRdELXD4FgtcI=;
        b=CSlDMzEDdNhF3xBn9yzXZt9gAtQX3iWOG9dJtHfsudpcaCWQGumlb4wGSTTDIGqiV3
         EeIn6TBI98TB8cTumFoVwmeH9QVdtMjVBrwQMjcg1thHFWSvc5xBGOgXvn5Gzm+uajDW
         yBSBTiennD9m3aWO7Sw5YBlujc0RmJoQPltmSkZJIyf72qRZT1eaPBHYGGa/z5/Nu+KN
         CTw9wRHEnJuRQxXxUI6pJEPFh3YxPmWup4ZTY08CGhb0zGaYvlNFiAWJIcY4BEFrU4s7
         yahzqO4B4wW6EKNYpQWSZ7npjywUX6frZmBNzTRtutxiuQpYqVSBorB2wOxc8LzKeFja
         NGtg==
X-Forwarded-Encrypted: i=1; AJvYcCVLqud5b4ocQlXIxwk9ymbH4WEY6D42hfA4gXQlPYrderz1O8qrWiJ7ycoLAT91ijQvt9C21BPjMWbAY4Makao=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvHKFarhWt0u2gwyyZKi2mJF7uoK9u9/ZY9rbxaE4ivyV0Du/9
	m0yuHrdefewzNuQhY2cjuobwPxCH2qfqbgWATAggZ9spAHu92zNZJk005TCfugZ+6q0=
X-Gm-Gg: ASbGnctfHQpapNHZyz0m/annWs796erC2dXqf3B9sQj0wuUG8LdkpGVJq+LoXNDaH1W
	J82Z1i/SYyxC+bnRPoR378XL0+PneGKxyoJYu4lvh/Ef41j1XgMfEyXGb3wxtFBb2PQpME2DDJ0
	5dlOKvJcxYl+VQO8poaQxI/sIBcs2F1NaJlNdgYIXquUBi4RO8GFEjwJ5dSoYk0tAril0yo2RgM
	yCWw/gKbMO4C8FbgtDAIAPKjYblJTJtgCQaFrJug4q7NU9B1I7fO+dzjyVxij2SruxkBg+tqeoj
	FmiGzYVg4A7wX7HvWZq6mokr2QZJntHSGZ2Ch3DYuu1LAJpKOPYzK/lQVQmTaTZfhJP2IIinUZQ
	MleOFwZkSeA==
X-Google-Smtp-Source: AGHT+IGd9CKACvtLyrQHHdrX6nttBshhd3uTSHt7m/xqpIEz2JTGn2U407DsxW/ZcIqykVDLTwW6Yg==
X-Received: by 2002:a05:6000:250e:b0:3b7:8268:8335 with SMTP id ffacd0b85a97d-3c5dcc0dd86mr22855026f8f.42.1756496034796;
        Fri, 29 Aug 2025 12:33:54 -0700 (PDT)
Received: from localhost ([177.94.120.255])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e9847da0a06sm981166276.18.2025.08.29.12.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 12:33:54 -0700 (PDT)
From: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Date: Fri, 29 Aug 2025 16:33:49 -0300
Subject: [PATCH] selftests/bpf: Fix count write in
 testapp_xdp_metadata_copy()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250829-selftests-bpf-xsk_regression_fix-v1-1-5f5acdb9fe6b@suse.com>
X-B4-Tracking: v=1; b=H4sIAJwAsmgC/x2N2wqDMBBEf0X2uQEberO/UkpIdKKhJcpuKAHx3
 7v6sswZmLMrCThB6NmsxPglSXNWOJ8a6iefR5g0KJNt7bV92M4IvrFAipiwRFPl4xgjQ/ahi6m
 a2/0y2M5CryfVLAytjxevt3LwAhPY537axbsloxYXZz4CbdsfmUQplpYAAAA=
X-Change-ID: 20250829-selftests-bpf-xsk_regression_fix-674d292e4d2a
To: =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Jonathan Lemon <jonathan.lemon@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 Tushar Vyavahare <tushar.vyavahare@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2049; i=rbm@suse.com;
 h=from:subject:message-id; bh=OArcrcPJKctf7kyzhyu5N9o4Z5m1mtDS835/OiICaDA=;
 b=owEBiQJ2/ZANAwAIAckLinxjhlimAcsmYgBosgCeMkw0JmQH1sVx8Ie24sG2wxN+m6s3zrnNT
 QJL2G/SuGiJAk8EAAEIADkWIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaLIAnhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQyQuKfGOGWKbbOg//aeQgH/RaZl6hnKGr9Y4sJQ8C7y5Ef9L
 pKIgXrcSFWHne+BBmxu20oK8ZUuAD25iR5lKX3D/11k5ybUB4SlP0+QLrSfdHIOv0chE+ughqDs
 gw3jWuyAeA9v8soWdvIyH626+aeT1rE401v1cfeO6C6Hs+CRHYoevxGB6vDeQ2BAWC2hGJ7ZT7A
 7PoiE5qzR7WeKuECK5A+lSTk0dpt2Pa+tOwAmed4Vs/spWNEhVk/qV3o2cRzZ7p/5i9T7JHQCBT
 89EzHrHG9UlfryoKgUh5e0PZqSblqEdtMg1dK0+hX2HgDUGkt3Z0TkcA8/kwwBjEQC0zGiOuI8h
 Rdf7qbl7f1h+K/xChY0/T6ovJArR+UCT3RVlglJwvBkiNze5emFqIvSHZNpL/kknbCnNAir/lVe
 y2VA17wsd8OgDpQDLtkLNVYxXr4FBA8EDHSDOp/rKHJnUyLOLUOEEp2U7oyGLSltha9L2T1qKyY
 jQ0QShWjWnRfcWTz/1XFLaHiWUOVnAWZ2g8N3WP6VfUenbAq42bS4CGtzTOj3xJpULNOhBWISjU
 gd4B+yycWRArtnKg9wcdiDCaIhW+aU5+PAQyX3kdZnSLdfzrmaq+PV0p2esjLFZpqFjxV44Fn/B
 Wb9CB7BGcbz0m96feLJdcU6jjQVeWByWzq1G7Jm9M8vJ7zg1q4zE=
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Commit 4b302092553c ("selftests/xsk: Add tail adjustment tests and support
check") added a new global to xsk_xdp_progs.c, but left out the access in
the testapp_xdp_metadata_copy() function. Since bpf_map_update_elem() will
write to the whole bss section, it gets truncated. Fix by writing to
skel_rx->bss->count directly.

Fixes: 4b302092553c ("selftests/xsk: Add tail adjustment tests and support check")
Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/xskxceiver.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index a29de0713f19f05ef49a52e3824bb58a30565e87..352adc8df2d1cd777c823c5a89f1720ee043f342 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -2276,25 +2276,13 @@ static int testapp_xdp_metadata_copy(struct test_spec *test)
 {
 	struct xsk_xdp_progs *skel_rx = test->ifobj_rx->xdp_progs;
 	struct xsk_xdp_progs *skel_tx = test->ifobj_tx->xdp_progs;
-	struct bpf_map *data_map;
-	int count = 0;
-	int key = 0;
 
 	test_spec_set_xdp_prog(test, skel_rx->progs.xsk_xdp_populate_metadata,
 			       skel_tx->progs.xsk_xdp_populate_metadata,
 			       skel_rx->maps.xsk, skel_tx->maps.xsk);
 	test->ifobj_rx->use_metadata = true;
 
-	data_map = bpf_object__find_map_by_name(skel_rx->obj, "xsk_xdp_.bss");
-	if (!data_map || !bpf_map__is_internal(data_map)) {
-		ksft_print_msg("Error: could not find bss section of XDP program\n");
-		return TEST_FAILURE;
-	}
-
-	if (bpf_map_update_elem(bpf_map__fd(data_map), &key, &count, BPF_ANY)) {
-		ksft_print_msg("Error: could not update count element\n");
-		return TEST_FAILURE;
-	}
+	skel_rx->bss->count = 0;
 
 	return testapp_validate_traffic(test);
 }

---
base-commit: 5b6d6fe1ca7b712c74f78426bb23c465fd34b322
change-id: 20250829-selftests-bpf-xsk_regression_fix-674d292e4d2a

Best regards,
-- 
Ricardo B. Marlière <rbm@suse.com>


