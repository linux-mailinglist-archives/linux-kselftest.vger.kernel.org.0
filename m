Return-Path: <linux-kselftest+bounces-27310-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E82EA4136F
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 03:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 964677A57F1
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 02:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCB92054F4;
	Mon, 24 Feb 2025 02:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X84TZ4gq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6F0202C44;
	Mon, 24 Feb 2025 02:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740363761; cv=none; b=QzRYVMCIvYU4fambvBZFZq/HH6zIAaCzz0DkWENbCUg/jp8wciA3+Lbd3qC1RrjIr6Vb+X5d5CyUNIzxi9iBBVYuEPxMcfn+ENg78/T3IhWOmWlf/X+F5eELGaJMkedTHELH7B/gzJ281FYE5Mw50lpge6Jr00bB/gzHQjpQXVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740363761; c=relaxed/simple;
	bh=x1RagGnEsGngNw3EY8nNKEZy+pH7qTCaixBwp6WaeUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jvdPrjBFDbn4V/XaKIRGAlM485biFgPD3CinoAJyFBYvl03qIe9luwyO/svYXZlld6bRYnk9g9QrddBdxsQbBZaaozXW10RKtR02gUDoG0PsQhFVXtOScqyoJVILcleAEpmm5HL+I+b2JNWJRQoO/PKeeoW0uNamzP6G+J5Pdxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X84TZ4gq; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e6621960eeso48879686d6.0;
        Sun, 23 Feb 2025 18:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740363759; x=1740968559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LYVXngARAHEiVLhrUvNNltGXmcHFU3g/uWrZ+f3iCoY=;
        b=X84TZ4gq6tQ3qHFKwFwJosUXNsyME9HArhW4ireHougv+e7EZR410YOyreB5r5MqVM
         WGWd4L4lqaRPXJGbInj8XxzlXlxtWGOU6tHZxHl6V1t3nvrboHD/U5M+K2Xw4zVuQjug
         KNc8UcuY58rSClsN8NL88XTQH3YuePTZ9zTKaabOz/b+p5pBiIyqwRyWKBz9H/fvjx8+
         o3DyPk4c9ovVXU3Y27jTCZ4E6XANvJdEgZcWnRZHzFFtFL0ozvBHIXZIc4n0qXl5sFSD
         3ENHD8muRKo29rMfzQUvNsyCyPQOv1no5BL2ODDINwP6bd3MjDPSa6LZHrnwLZz/IBRH
         r38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740363759; x=1740968559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LYVXngARAHEiVLhrUvNNltGXmcHFU3g/uWrZ+f3iCoY=;
        b=vojje5ZMZoEZNuZL5UxlcLe59C97ENJyTQ6PRem2dGl4Mi7dAR0SXBK5x7XlKxvMft
         kX+VUrE+4/2n1hNY2XkWrdtlgKabqheC+PdVmEKy+anIQzh7k8b5pOy9IfWq6TQCCp4n
         o7YqulNTXZaV+elBEARtEx1m/0lmU6qwxt0zeBpdr2HbUTsEH/gRk9dZYp2civjQhyOJ
         VQ3Prd2pRM8GRwvT5qMQJEs7pj35fEFKb9wudWqyjGGQx70wvAI7FrTCuK7t9yN2zist
         HoB7NVWqutLYzaziq3v/26TUqTGGnL47+/94uNHXW0gmasgz76e0GK5sjJPFgm9c7HTc
         dzBg==
X-Forwarded-Encrypted: i=1; AJvYcCUqkc6Owwky4vy2RGsuifaLbKw6FMOp3VknVwRRLL5NCy/CNCwjqy9QcT9RPGY8zWJW7XjAfPJLBANKjmbcuEvW@vger.kernel.org, AJvYcCV7fZieXfRWUnnPM5a9wpzBatFbZbmM4i19FKGXwuwYcgvq0+kRmvAILYX/Ly29A6MmHus=@vger.kernel.org, AJvYcCWCS+u4g/FBbCW1HAIkEps0IZsSSLEwVlgm+Le4pv70/q79kePxsHzAv5+COMrRoS7t7SIuvgyu5o4cEuC+@vger.kernel.org
X-Gm-Message-State: AOJu0Yyktw6NfxiIbpsG0uVmMIml3fZZ/3gGGSSrcaA5to7NRsEcRyFn
	glQSCxC7Mkhzf1t/ZbTWdmWxgJyi3rbDCI0GuQ8rhwa9ODpwkmOT
X-Gm-Gg: ASbGnct5epEnVQyZDF878nneLW3Xflj/GFgHNvfU636AiktYwRisbvc/9noTg8GWCA7
	wIpChg/VgUlUdKMBdE0Oka2xt/RhCTgOCW8eIOrleok4UL9S+d4EZPxtb6Rt4d522ram2HWPk9n
	DB9cVUYoGUmCoKfg3rh0X41YO3dbjK+MdLxqU6xSmKbkkWMByJTGE1pccDyfSKlVTDOE87P06wu
	tUSjEydr31wojt99zbZna25tKiqG/YVvfDjZZvcBXk2x/abamcB48e+b1xlHwfwt2lyU/7fvCCi
	Oo7FyOhGYJNMSi5yPToj4FE9tcFv78P650p2sErdyNU9LcD+6OVZZr4aJ7ScMRRJW1t3fcJhomT
	ZXKM7jr/UpEizxhVL
X-Google-Smtp-Source: AGHT+IHZEXr3FBaKPE3j25LAFJ0ZFPpAKJCewtDs9aZxscFGONzRa6lLREjHVfy2UJiJ5PQf0mtAdQ==
X-Received: by 2002:a05:6214:1250:b0:6e2:3761:71b0 with SMTP id 6a1803df08f44-6e6ae72d99bmr175752656d6.5.1740363758761;
        Sun, 23 Feb 2025 18:22:38 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d71721csm128183396d6.0.2025.02.23.18.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 18:22:38 -0800 (PST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id DD8B81200043;
	Sun, 23 Feb 2025 21:22:37 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sun, 23 Feb 2025 21:22:37 -0500
X-ME-Sender: <xms:7de7ZyAG-9izWVtbrVdylp29QXN9BlqgmriQjOm9rJxAnlGxcrJs4g>
    <xme:7de7Z8h32Jd1enx6U8mi82vp12P2DxOM62QzaVE23LlRRI1P1IFpu7nzblBXil5F3
    r5sPjle8Fjz1Cvkww>
X-ME-Received: <xmr:7de7Z1kIifYKDfn9py8jtlZe_iysSaIq9HMp5nooIuWsEGB-c4kRoD20rQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejjeehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfev
    ffeiueejhfeuiefggeeuheeggefgnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvuddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehjihgrnhhgshhhrghnlhgrihesghhmrghilhdrtghomhdprhgt
    phhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhshh
    esjhhoshhhthhrihhplhgvthhtrdhorhhgpdhrtghpthhtoheprhhoshhtvgguthesghho
    ohgumhhishdrohhrghdprhgtphhtthhopehmrghthhhivghurdguvghsnhhohigvrhhsse
    gvfhhfihgtihhoshdrtghomhdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepnhgvvghrrghjrdhuphgrughhhigrhieskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepjhhovghlsehjohgvlhhfvghrnhgrnhguvghsrdhorhhg
X-ME-Proxy: <xmx:7de7ZwzwxzrFLYFpviodeuEGkJVsNDYbfWnb36_vh-XRgGW2vgmQ6Q>
    <xmx:7de7Z3TBH5gwla_J8ONtd1Ju7XnPbGopWPwTmBXW85eXl9BIHDO1Kg>
    <xmx:7de7Z7YyKr1Nq9iwVX07gb9e5L2yBrq7OHpIgj_bh-3JU-g3nZ36kg>
    <xmx:7de7ZwSt7Hoy7_aGlAsAhnSuwcZC6iyR8maT_F1LhI__18YY61zrSQ>
    <xmx:7de7Z5APmPq87ciy-ssDz3ptHtFwssmuio-XcIglb_VVds3dH8mvblfn>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Feb 2025 21:22:37 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: rcu@vger.kernel.org
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH rcu 14/20] rcutorture: Add ability to test srcu_read_{,un}lock_fast()
Date: Sun, 23 Feb 2025 18:22:08 -0800
Message-Id: <20250224022214.12037-15-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250224022214.12037-1-boqun.feng@gmail.com>
References: <20250224022214.12037-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit permits rcutorture to test srcu_read_{,un}lock_fast(), which
is specified by the rcutorture.reader_flavor=0x8 kernel boot parameter.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/rcutorture.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 1d2de50fb5d6..1bd3eaa0b8e7 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -677,6 +677,7 @@ static void srcu_get_gp_data(int *flags, unsigned long *gp_seq)
 static int srcu_torture_read_lock(void)
 {
 	int idx;
+	struct srcu_ctr __percpu *scp;
 	int ret = 0;
 
 	if ((reader_flavor & SRCU_READ_FLAVOR_NORMAL) || !(reader_flavor & SRCU_READ_FLAVOR_ALL)) {
@@ -694,6 +695,12 @@ static int srcu_torture_read_lock(void)
 		WARN_ON_ONCE(idx & ~0x1);
 		ret += idx << 2;
 	}
+	if (reader_flavor & SRCU_READ_FLAVOR_FAST) {
+		scp = srcu_read_lock_fast(srcu_ctlp);
+		idx = __srcu_ptr_to_ctr(srcu_ctlp, scp);
+		WARN_ON_ONCE(idx & ~0x1);
+		ret += idx << 3;
+	}
 	return ret;
 }
 
@@ -719,6 +726,8 @@ srcu_read_delay(struct torture_random_state *rrsp, struct rt_read_seg *rtrsp)
 static void srcu_torture_read_unlock(int idx)
 {
 	WARN_ON_ONCE((reader_flavor && (idx & ~reader_flavor)) || (!reader_flavor && (idx & ~0x1)));
+	if (reader_flavor & SRCU_READ_FLAVOR_FAST)
+		srcu_read_unlock_fast(srcu_ctlp, __srcu_ctr_to_ptr(srcu_ctlp, (idx & 0x8) >> 3));
 	if (reader_flavor & SRCU_READ_FLAVOR_LITE)
 		srcu_read_unlock_lite(srcu_ctlp, (idx & 0x4) >> 2);
 	if (reader_flavor & SRCU_READ_FLAVOR_NMI)
-- 
2.39.5 (Apple Git-154)


