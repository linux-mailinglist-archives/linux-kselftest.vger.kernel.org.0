Return-Path: <linux-kselftest+bounces-18097-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A18E797B8B0
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 09:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F877B24E8B
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 07:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11B5176248;
	Wed, 18 Sep 2024 07:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ARRtXAqB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FA9482EF
	for <linux-kselftest@vger.kernel.org>; Wed, 18 Sep 2024 07:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726645549; cv=none; b=mHUqmGY1NqiImMdMgo1z5albS9rE9KV6a7o6V68zJ32ujIMV+XcDcy1uk9m61Mi32l5DNHC3xIIVnDtHXgb5m/rEzMFPnM2qZkZFDEt+1DYKvHYdbIECFX1lqBtFHWZ5wsOLVqfARXY6vkoYsN96r/6BeuuzYNgEE12aY2DG5A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726645549; c=relaxed/simple;
	bh=DydfF8Pc439Wt1w5M+gW9vt8fw8CSe77hlZ+Dv3Cw6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TaTMd6Lqk26LTxainwTmqOliPWeexrk1tIayIdNMp1llY0KuUr2EJgeoriJopRigumWnCKWXfg16dNwhk7qoeaxW50xguyEAWXoIABhPV/dIYjYJsT//zMT9u2vZl/5NqZOA1WM5iZ3tlM+yAjf92b2FQFwVA0JLWnUoRb/YgLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ARRtXAqB; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20570b42f24so69386645ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Sep 2024 00:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1726645546; x=1727250346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWqoVAK5c9pomygUoi1VenHzK4hkTh05ICoLnHqqtLI=;
        b=ARRtXAqBLB5lln5zEU7CA/T2/PCbYoMNvcefdCEVN7b3giGTdjP+X7ysrq8y+Ay1cc
         lfljyn2Ft/rK9KyWEjztTTw0nlcWWC34Gqsul0llDGtFrqnX97QiNAx03w4cLRvXwxkx
         1eRnNxFcxWvRDfR7d5oWrSs7bij97KjQle4VyNHp20uCNtzEOTE0h92yjJ4bDAHTZKYl
         +qN70KdIg1HWJtxVFSx7QMXKMMAeiq7aHB44UZSnYyLUK8vgC/Cifs5anPAjQSvCcodb
         sIfrZci0VzyGcrK6ZD/smD5j3jeVdeUSiWfrVDrVbn1m1vQzRnpRa3SwBZaAmyYEL6O/
         NTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726645546; x=1727250346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWqoVAK5c9pomygUoi1VenHzK4hkTh05ICoLnHqqtLI=;
        b=SPiIDI4ka2byplLD+IWxUYqa1wI6rej8eoRS90aGtTrfKU8pM+LfZKM8T4UGZUolGE
         e/hR61NimU4EQnN96mYPMBc2oaDHXfuwLqn3SCUFcYrv86MPeSCzrqNqGaP0xTpsKCBk
         LMw7fOE5UBo7fMbktLRje8SBOqh1H+ICy2P8Jbbov2JtyTAifylE1pozyecI9UieDufA
         KE1WHNqdxVnRw6VVRrWn9Urak+n2ST3dVvWwriu8hBPgQIj6TiBHxDYlOlYqte/Ez0Pi
         YiokE+pCKnKRGGe+AjW3ym/sPzEEDQKG1q6MKUez3FRORSkAlGURmqlzzFfnUHdbDIqJ
         KFkg==
X-Forwarded-Encrypted: i=1; AJvYcCVKzC9z4uoBDn1Riz5POKSaxYogMdMz36IfWlu+bjlp6YPxdv5YqehaAxLBoofp4zCyjZC2kCU9hGJBzUrJxvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwIenUGaK4Bp9gExckPhWl3Me7bjgsNB/1jjtTY1jxB2emId8f
	rGxbGWlaSHPOp1hbcSnmzPLEcEDceS105dy4RsphKOT4klrjPWUvvIzloHLNO8s=
X-Google-Smtp-Source: AGHT+IGVPp2n40PuG/8KbAxshSN8LnfmvU7GlDwe9HJB5DsmANQ6cspxjCvOOmjG4ThxTHfHWIy/5A==
X-Received: by 2002:a17:903:26ce:b0:206:d66d:a30d with SMTP id d9443c01a7336-2076e3155bdmr241941755ad.6.1726645546538;
        Wed, 18 Sep 2024 00:45:46 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([203.208.167.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794747379sm60412995ad.288.2024.09.18.00.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 00:45:46 -0700 (PDT)
From: Feng zhou <zhoufeng.zf@bytedance.com>
To: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mykolal@fb.com,
	shuah@kernel.org,
	geliang@kernel.org,
	laoar.shao@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com,
	zhoufeng.zf@bytedance.com
Subject: [PATCH bpf-next v2 1/2] bpf: cg_skb add get classid helper
Date: Wed, 18 Sep 2024 15:45:14 +0800
Message-Id: <20240918074516.5697-2-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240918074516.5697-1-zhoufeng.zf@bytedance.com>
References: <20240918074516.5697-1-zhoufeng.zf@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Feng Zhou <zhoufeng.zf@bytedance.com>

At cg_skb hook point, can get classid for v1 or v2, allowing
users to do more functions such as acl.

Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
---
 net/core/filter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index e4a4454df5f9..a4aa39b6dbba 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8115,6 +8115,10 @@ cg_skb_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_listener_sock_proto;
 	case BPF_FUNC_skb_ecn_set_ce:
 		return &bpf_skb_ecn_set_ce_proto;
+#endif
+#ifdef CONFIG_CGROUP_NET_CLASSID
+	case BPF_FUNC_skb_cgroup_classid:
+		return &bpf_skb_cgroup_classid_proto;
 #endif
 	default:
 		return sk_filter_func_proto(func_id, prog);
-- 
2.30.2


