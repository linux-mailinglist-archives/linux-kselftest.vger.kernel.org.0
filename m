Return-Path: <linux-kselftest+bounces-28284-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCDEA4F524
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 04:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D64BF3A978F
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 03:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E8319D062;
	Wed,  5 Mar 2025 03:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwNrF/m3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266CC199E89;
	Wed,  5 Mar 2025 03:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741143946; cv=none; b=SlSxvgnddFWQNceAL6LchnYjv4nid5ixAR+R1Ao8a/2EBLAsjbo9ZskM3LmaPmI22Btp0oa5F7wNSMQPGz4Kv3tSnJjz0xXUkk0SetXGg3K77NEgvjkPU9nObOWdOUN9eIxlJ0h5b2ID78jFmWTOGCkWPrM/wIT7whhahDDmWjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741143946; c=relaxed/simple;
	bh=tmzTUwcDvfcoyJpi6SQQUu4XwTaZg+heQ4riDadkSPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S5SqrmDWnsMKnNtulSQD/LpEPrSGI4uVyAU9L6DDsSOaFqpi7bTTODl91n0NQASJaBeYARvshZnd+HQ/stoOy7iPnhVa5Yd77H15MQE+QjNZ40nxlLtk7gZuM0Uh95+Qxh9Diki1LV3fCmRjhfoUFJSxabvui0GJkZs+4Nvdufc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwNrF/m3; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7be49f6b331so615729485a.1;
        Tue, 04 Mar 2025 19:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741143944; x=1741748744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZWUbTmfZeSTAjfInLJsRKj3El0zpw1/MvyJ1JvXIc1U=;
        b=WwNrF/m3DzrKJIka2pBn9Mf15dXkgXe6/dod3d6YmHKOpSJdvxrsB2wTi3hdvDNYFo
         xrEDnFiJPRWDCk8TGfURDPs/EE3ZuCg/0497NQSQ19OwiEseliYJnZBVRhPdnJP3NmYL
         4Y5anx++QmLL4Zzf6HIdVNayuRj1/I4jDtobB7J1goaPumLfYil8LoZqmzQh/TJGiKeT
         ASDC+vK919IN3rKDZQoWY0rB7jqN41ag652lyDFusF/aTNvYJFbLytzu8HdxPTamA9oO
         cNId6FaEHqW5A8lWAT1lMyC1NoIYLvfp+EiBhinTgaO1Zsrru0jnTTEK5CmF6VcpjRsf
         BPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741143944; x=1741748744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZWUbTmfZeSTAjfInLJsRKj3El0zpw1/MvyJ1JvXIc1U=;
        b=UaJTB8oP+Yx6k/ZBvHhfpMVmv9/u8G8L4ysXA/xikdzElm+BFZSyT7i04dLY/GufN0
         p5nU73YC4qLBowB3OtbbVoJXlInEAdU3L0XTZnDoVw0uDmjWVSzeBclpV356xvwIZQNQ
         sbxU5Cc+qpW64ykvlgjkLFHN/LH/qHnzotYKj4ntHTaiuwMfWhAEAdtNwRg0h1MN9FgG
         XW+qplzsrg7bMLE5ipwA05CJCdaJpG/njg+sSQGaQS6czYYQBuhWAMSxd+TKE+AizhT/
         3q+u75yFQUwcjlL9zfpQDTidr9EQ3DkJ8rj20R4HO+zzr5BGwViQptJ3KO2+tcgS/y4m
         aYTw==
X-Forwarded-Encrypted: i=1; AJvYcCVZsdD0smYPmXW8krW1zElovfvR+t0aw+ucDSSn7qW6btBgXzVFRUqQnPqLd8OdU4jTKCKc9UKLtamJwHV8d3Tp@vger.kernel.org, AJvYcCWAhkwQDG9/g4v+F1Va3ZbLgYOxTu9mPCCBC8Tq59mi6QF44Iw+lb1upXf4a/5v5EmHB4krbKaJYmhYDds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd05E5ge8HSNAiRfcyz9Ye8Tg8RnatVzWB86zebB/s1NIsN4RI
	RFF2tvB3Ca811u3aAhCQlO4UguNLGQp7iXiM3f+tDg19wbIal5JR
X-Gm-Gg: ASbGnctZCxuAVudQKcq2kjggBuOKe5k8EZ0UZjzK90V0eqVrjwvlZjAhTElYlV6LDYM
	Vrz3w4JeWU0aMBkwjyHxpdudUBUd/gVV3X8aplvuIjH0YgmWs1TDPfqzMibMn/ze/R630keO6Nt
	lyElVsxt1fjWRYtqv57E9zz0GC2NI72yAUyPkbm/d/jfkhqe4gkSwMi4y5OlB4M2FJg//gr/K1q
	vZbPvdccbFBEu5Wty42RRdRIsaLPSclQ52B53OMAp1xagd20a4qUa0MIC6VdBdrK4XdFFo6tccL
	DJGDrcY8Yr0XKiri5Ac+27IQsQELNMdYAbn2n87NNr3GjXLqxQO/R8HSCgfQFqQxiFkoe3W6pVt
	JDV9j0Ewd4rSvQMk6Hryzs5Po+7FjNH+/qfY=
X-Google-Smtp-Source: AGHT+IGbpMYWPfZVn/GZecxLR58PtHpyaPX50Ibx/nZVKroR/TmXFshuqFOaLzZeECRWUFdnxpEcCA==
X-Received: by 2002:a05:622a:1389:b0:471:ef27:a314 with SMTP id d75a77b69052e-4750b442bafmr21764871cf.18.1741143943723;
        Tue, 04 Mar 2025 19:05:43 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474e3affc66sm38282841cf.4.2025.03.04.19.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 19:05:43 -0800 (PST)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 97BEF120006C;
	Tue,  4 Mar 2025 22:05:42 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 04 Mar 2025 22:05:42 -0500
X-ME-Sender: <xms:hr_HZzVCp4811y1v0HMNE_DtrqokZWSdaDFbovUtWwaERI2lu0Aq4Q>
    <xme:hr_HZ7nqhLbFnarche3oZknQ6XfgFb7KrnZd6ncqcdRJ7FGK_KIXlVNHH1iGrASeF
    GQWKoPQ9BK-M_zocg>
X-ME-Received: <xmr:hr_HZ_Z-Zumty-cK5DUOI51o9ch5ijm1kpdkpk-PbWHDfDowJaFBEuy6zQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdefjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefghfffvefhhfdvgfejgfekvdelgfekgeev
    ueehlefhiedvgeffjefgteeugfehieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopeefjedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpmhhlrggu
    vghksehsuhhsvgdrtghomhdprhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrd
    horhhgpdhrtghpthhtohepjhhohhhnrdhoghhnvghssheslhhinhhuthhrohhnihigrdgu
    vgdprhgtphhtthhopehsvghnohiihhgrthhskhihsegthhhrohhmihhumhdrohhrghdprh
    gtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehfrhgv
    uggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvvghrrghjrdhuphgrug
    hhhigrhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhovghlsehjohgvlhhfvghr
    nhgrnhguvghsrdhorhhg
X-ME-Proxy: <xmx:hr_HZ-V-YBozAK7CCv8OxamG-SRbo5G15qpPCTYu4D9taV01LIDD6g>
    <xmx:hr_HZ9mJd7oxi4FK58Ax757qYdoqz4-06OfOi7t-hK3sXm-GFV4iQA>
    <xmx:hr_HZ7dDsY1vyGHFINXzWx92JYLFx8XN55FOhLYkfWClvMcUPRb9iQ>
    <xmx:hr_HZ3HQoSgxVXQpi0-j-6QNgesuJC1i_0KriWtVJI5OBaaesmne6Q>
    <xmx:hr_HZ_kSCN3Axlt1Ye46jHGuLLDHmwIStdSvnRj_-BNEeWxlziVot4bQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 22:05:41 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: rcu@vger.kernel.org
Cc: Petr Mladek <pmladek@suse.com>,	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,	Davidlohr Bueso <dave@stgolabs.net>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,	Yuntao Wang <ytcoode@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Guo Weikang <guoweikang.kernel@gmail.com>,	KP Singh <kpsingh@kernel.org>,
	Huang Shijie <shijie@os.amperecomputing.com>,
	Raul E Rangel <rrangel@chromium.org>,
	Joel Granados <joel.granados@kernel.org>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	zhangguopeng <zhangguopeng@kylinos.cn>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Neeraj Upadhyay (AMD)" <neeraj.iitr10@gmail.com>,
	linux-kernel@vger.kernel.org,	linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH rcu 09/10] rcu: Update TREE05.boot to test normal synchronize_rcu()
Date: Tue,  4 Mar 2025 19:05:04 -0800
Message-ID: <20250305030505.94059-10-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305030505.94059-1-boqun.feng@gmail.com>
References: <20250305030505.94059-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

Add extra parameters for rcutorture module. One is the "nfakewriters"
which is set -1. There will be created number of test-kthreads which
correspond to number of CPUs in a test system. Those threads randomly
invoke synchronize_rcu() call.

Apart of that "rcu_normal" is set to 1, because it is specifically for
a normal synchronize_rcu() testing, also a newly added parameter which
is "rcu_normal_wake_from_gp" is set to 1 also. That prevents interaction
with other callbacks in a system.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Link: https://lore.kernel.org/r/20250227131613.52683-2-urezki@gmail.com
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 tools/testing/selftests/rcutorture/configs/rcu/TREE05.boot | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE05.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE05.boot
index c419cac233ee..54f5c9053474 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE05.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE05.boot
@@ -2,3 +2,9 @@ rcutree.gp_preinit_delay=3
 rcutree.gp_init_delay=3
 rcutree.gp_cleanup_delay=3
 rcupdate.rcu_self_test=1
+
+# This part is for synchronize_rcu() testing
+rcutorture.nfakewriters=-1
+rcutorture.gp_sync=1
+rcupdate.rcu_normal=1
+rcutree.rcu_normal_wake_from_gp=1
-- 
2.48.1


