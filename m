Return-Path: <linux-kselftest+bounces-28278-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 000F0A4F518
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 04:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BEB816B592
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 03:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0402615CD74;
	Wed,  5 Mar 2025 03:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hh8OlOoX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB04189BB6;
	Wed,  5 Mar 2025 03:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741143925; cv=none; b=nM6sF9yf/ar0iKtqwjCoGOwsBFqY8VwS026Yx1tT/xyOvNvcPocomyIWOQCJNnjkazWyKtpZhQ3M+RtD+Lp+lry/cnFjxzUdkB5+gaHAndgE6+aLQUOJi/HWzUSPgpVespo06b1E6nBDQvj0Cv44yl9IRYC8bQtgOuQwHZQNTrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741143925; c=relaxed/simple;
	bh=adMX+dMsvQKA4HQUhdFW7hCyoQY2Szn+ZPD3KuV4Ogs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BvfOik20dMJW73e1HVvD/BM9kUW0ID/XYv19Hz7nTSUb24zRjtFyv1/yYEFPrgWq0W4UcZQmIDidaNQYrUPyRHOvDEBrw4CHxifDecK/QiyQrtLRccK10ao+drpcU4L58MNw2BSpwUcQk4lZ4HtzLn9Sa/wdf9G1yiWmJvERsu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hh8OlOoX; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c08fc20194so1061823885a.2;
        Tue, 04 Mar 2025 19:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741143921; x=1741748721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TREe/GczQCdCVP8xv9UeUs+VSfmkQsfQHVm77Mom6fk=;
        b=hh8OlOoXOhYQAyPicSJdJNfhRU1LwV2xdySz9F0oCa0hCH5WTjghnIPEL4ABCLDWyX
         uDpGQog8BmpMgXqpiZZIatYXr2DgqOwLhomlBCuOKddqUXrwVQolAba0KH4pMg5M255z
         Hdwb9p6rlfxlfPinp1+Ot7uvtnMTqBhgzYMBiAnnsf8TO52EekkHU5gUYXSSpnVhvUsL
         CzyqOcRi5wpdweSo7eRtTN0XqkJmODgyO+EFT66CoGyftYBJycqFUfJq4pTq+2DWFtyB
         6l51zLxSUGtjl+MFwPJ7Muc2Msk/xxKYU3iH1VQv+QvZ9gK49inx5JyFASwZh/CryNUd
         zEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741143921; x=1741748721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TREe/GczQCdCVP8xv9UeUs+VSfmkQsfQHVm77Mom6fk=;
        b=t0tbIMRLQm1GEjdWBCi/MyfwzXL05nEShTzaIhD9XfU6f0Mkgw5AEXwLzIZfgQ75jQ
         eOSdh5+02KZX5ILzhifUfztHuwz2oxH89a2EbPCvyJLq+MfLlGjO/8sNcmKj39y9wYEv
         xFc3GmoBByec+/Af/9zgtGwjQiZP8YU0qcPXQ8RpB1RNOLjS5fiw/FReLT13TLrk0RWw
         Nwq+cjfJN5HqSV9hQFY0D7sG2icjLPSn5596mNHHTrfS+Wihct7P41TXVmpqJ6QP2sYJ
         tsA9eblhJBqQtKo5DvOdeGumwk313f0Lj09RaCyiTjnb/RXH84lHzFErVWt6D7Ak0E4y
         LOxA==
X-Forwarded-Encrypted: i=1; AJvYcCXBDo8oGfgHnA6rA0Uoz11Z8jUeXREJa8Ojl7O0+BA7OWLaRTsyqeGByAW24h69+Aq5ArYIO4GKbIUECVI=@vger.kernel.org, AJvYcCXLYau4FDOo04zwKOX/103j9mQOrlVOglKe+cXakfjqmONBXC23YW2k+CtM+T/qWX2wxgF2J+Ge72zhKE6EdMoP@vger.kernel.org
X-Gm-Message-State: AOJu0YzvNiiYi66TktakMuleKnsooBoqKCyhMGW2NMORs3p+9PuyKyFz
	17TuBNbJF71Q1e2mo0jX/5cTz79Xp/Hf5S9JxdTlNx7hrIOZT2Kh
X-Gm-Gg: ASbGncuTPmVB56iscGG/BFKFh5fPJJJy0SK3S5IEcQlCxNof+ecA+WXhS3tqOe3p5aT
	G5L3PDfkwD/KcLlDK7N3x5UDrc6v4/RCIzcs+auSghpPndDX6tPPxwfgTcFmGREE6sIMJODGQgK
	MkE+VeO6EsYzC9vSJij5KgoC2qEKxQaeZv1MTxXp6lc+OTuyKjKpEg0u7rtb5VanTOzFEWVChFK
	gqUuiga0TjplHXUoIodGhpn2lOfmBskGK6tuexCKR6nSJ9ZIsr7evni/2xSUEZT39OKpKC1aSzd
	5ThaKBfFxlrcoQAuEEh6JIZhzoe38osk9x6fzgJUayTrnp8yBdlHcGRcsy6rX53yfwrs48G2mrk
	CUd0n1Ali1tOhDxnrY53v1a6PI0N3DY3IP0k=
X-Google-Smtp-Source: AGHT+IGw01pjVMH6zPVh6zX2lReIYZbwSMgdLWY0SQZkkYGuKVTTap6vTQ91XjXJCakyuYJGmeqP0w==
X-Received: by 2002:a05:620a:640b:b0:7c3:d2e9:b6d6 with SMTP id af79cd13be357-7c3d8e8c0c3mr318383785a.49.1741143921368;
        Tue, 04 Mar 2025 19:05:21 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3cd20e6bdsm195370085a.23.2025.03.04.19.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 19:05:21 -0800 (PST)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4EF10120006B;
	Tue,  4 Mar 2025 22:05:20 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 04 Mar 2025 22:05:20 -0500
X-ME-Sender: <xms:cL_HZ_t4cUpMbjdGhYLECW2p3ZrKOK0SWKr-TiRe6-D2mZzRjOe4VQ>
    <xme:cL_HZwchXB7-XEtOOOLQQf8nvsOn6_KzzKWJL7_OmfNgIZ10maEnwM7ROcxrNxMl5
    nzTd955jiMKidOfBA>
X-ME-Received: <xmr:cL_HZyyyui61UhmFEqDdmrffvvjRFoEp193mqVc8DDNSzIs5vAp_goJYGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdefjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertder
    tdejnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrg
    hilhdrtghomheqnecuggftrfgrthhtvghrnhepgeffjedugeeujeejiedvueetjedvuddv
    uddvfeeludegjefhleeiudfhgffggfffnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhq
    uhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqud
    ejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgv
    rdhnrghmvgdpnhgspghrtghpthhtohepfeekpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehrtghusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhmlhgr
    uggvkhesshhushgvrdgtohhmpdhrtghpthhtoheprhhoshhtvgguthesghhoohgumhhish
    drohhrghdprhgtphhtthhopehjohhhnhdrohhgnhgvshhssehlihhnuhhtrhhonhhigidr
    uggvpdhrtghpthhtohepshgvnhhoiihhrghtshhkhiestghhrhhomhhiuhhmrdhorhhgpd
    hrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhr
    vgguvghrihgtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvggvrhgrjhdruhhprg
    guhhihrgihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohgvlhesjhhovghlfhgv
    rhhnrghnuggvshdrohhrgh
X-ME-Proxy: <xmx:cL_HZ-PQBE9mfkedOdDDGcJzQ8e5SnmPWXsH3Di8SgX1xYSAX41O4w>
    <xmx:cL_HZ_-mQKCosG-RC3JV5UyTwtb2VbttwogyeRaXZwTKM0wjXaEHJg>
    <xmx:cL_HZ-XQiueVF6ijxNVZnArhvX3wuMeNpET9P9pyq_ZABcjc6ngmcg>
    <xmx:cL_HZwdBgunF8rVBe5cLAd_XW8fO4SHyFXRblzMZpweQtZOBL3VXFA>
    <xmx:cL_HZ9fGBoCYycNgNj698MML-BP-4fKVShLjoFbSZ3AVEOGSGTomrnQz>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 22:05:18 -0500 (EST)
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
	linux-rt-devel@lists.linux.dev,	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH rcu 03/10] rcu: Fix get_state_synchronize_rcu_full() GP-start detection
Date: Tue,  4 Mar 2025 19:04:58 -0800
Message-ID: <20250305030505.94059-4-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305030505.94059-1-boqun.feng@gmail.com>
References: <20250305030505.94059-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

The get_state_synchronize_rcu_full() and poll_state_synchronize_rcu_full()
functions use the root rcu_node structure's ->gp_seq field to detect
the beginnings and ends of grace periods, respectively.  This choice is
necessary for the poll_state_synchronize_rcu_full() function because
(give or take counter wrap), the following sequence is guaranteed not
to trigger:

	get_state_synchronize_rcu_full(&rgos);
	synchronize_rcu();
	WARN_ON_ONCE(!poll_state_synchronize_rcu_full(&rgos));

The RCU callbacks that awaken synchronize_rcu() instances are
guaranteed not to be invoked before the root rcu_node structure's
->gp_seq field is updated to indicate the end of the grace period.
However, these callbacks might start being invoked immediately
thereafter, in particular, before rcu_state.gp_seq has been updated.
Therefore, poll_state_synchronize_rcu_full() must refer to the
root rcu_node structure's ->gp_seq field.  Because this field is
updated under this structure's ->lock, any code following a call to
poll_state_synchronize_rcu_full() will be fully ordered after the
full grace-period computation, as is required by RCU's memory-ordering
semantics.

By symmetry, the get_state_synchronize_rcu_full() function should also
use this same root rcu_node structure's ->gp_seq field.  But it turns out
that symmetry is profoundly (though extremely infrequently) destructive
in this case.  To see this, consider the following sequence of events:

1.	CPU 0 starts a new grace period, and updates rcu_state.gp_seq
	accordingly.

2.	As its first step of grace-period initialization, CPU 0 examines
	the current CPU hotplug state and decides that it need not wait
	for CPU 1, which is currently offline.

3.	CPU 1 comes online, and updates its state.  But this does not
	affect the current grace period, but rather the one after that.
	After all, CPU 1 was offline when the current grace period
	started, so all pre-existing RCU readers on CPU 1 must have
	completed or been preempted before it last went offline.
	The current grace period therefore has nothing it needs to wait
	for on CPU 1.

4.	CPU 1 switches to an rcutorture kthread which is running
	rcutorture's rcu_torture_reader() function, which starts a new
	RCU reader.

5.	CPU 2 is running rcutorture's rcu_torture_writer() function
	and collects a new polled grace-period "cookie" using
	get_state_synchronize_rcu_full().  Because the newly started
	grace period has not completed initialization, the root rcu_node
	structure's ->gp_seq field has not yet been updated to indicate
	that this new grace period has already started.

	This cookie is therefore set up for the end of the current grace
	period (rather than the end of the following grace period).

6.	CPU 0 finishes grace-period initialization.

7.	If CPU 1’s rcutorture reader is preempted, it will be added to
	the ->blkd_tasks list, but because CPU 1’s ->qsmask bit is not
	set in CPU 1's leaf rcu_node structure, the ->gp_tasks pointer
	will not be updated.  Thus, this grace period will not wait on
	it.  Which is only fair, given that the CPU did not come online
	until after the grace period officially started.

8.	CPUs 0 and 2 then detect the new grace period and then report
	a quiescent state to the RCU core.

9.	Because CPU 1 was offline at the start of the current grace
	period, CPUs 0 and 2 are the only CPUs that this grace period
	needs to wait on.  So the grace period ends and post-grace-period
	cleanup starts.  In particular, the root rcu_node structure's
	->gp_seq field is updated to indicate that this grace period
	has now ended.

10.	CPU 2 continues running rcu_torture_writer() and sees that,
	from the viewpoint of the root rcu_node structure consulted by
	the poll_state_synchronize_rcu_full() function, the grace period
	has ended.  It therefore updates state accordingly.

11.	CPU 1 is still running the same RCU reader, which notices this
	update and thus complains about the too-short grace period.

The fix is for the get_state_synchronize_rcu_full() function to use
rcu_state.gp_seq instead of the root rcu_node structure's ->gp_seq field.
With this change in place, if step 5's cookie indicates that the grace
period has not yet started, then any prior code executed by CPU 2 must
have happened before CPU 1 came online.  This will in turn prevent CPU
1's code in steps 3 and 11 from spanning CPU 2's grace-period wait,
thus preventing CPU 1 from being subjected to a too-short grace period.

This commit therefore makes this change.  Note that there is no change to
the poll_state_synchronize_rcu_full() function, which as noted above,
must continue to use the root rcu_node structure's ->gp_seq field.
This is of course an asymmetry between these two functions, but is an
asymmetry that is absolutely required for correct operation.  It is a
common human tendency to greatly value symmetry, and sometimes symmetry
is a wonderful thing.  Other times, symmetry results in poor performance.
But in this case, symmetry is just plain wrong.

Nevertheless, the asymmetry does require an additional adjustment.
It is possible for get_state_synchronize_rcu_full() to see a given
grace period as having started, but for an immediately following
poll_state_synchronize_rcu_full() to see it as having not yet started.
Given the current rcu_seq_done_exact() implementation, this will
result in a false-positive indication that the grace period is done
from poll_state_synchronize_rcu_full().  This is dealt with by making
rcu_seq_done_exact() reach back three grace periods rather than just
two of them.

However, simply changing get_state_synchronize_rcu_full() function to
use rcu_state.gp_seq instead of the root rcu_node structure's ->gp_seq
field results in a theoretical bug in kernels booted with
rcutree.rcu_normal_wake_from_gp=1 due to the following sequence of
events:

o	The rcu_gp_init() function invokes rcu_seq_start() to officially
	start a new grace period.

o	A new RCU reader begins, referencing X from some RCU-protected
	list.  The new grace period is not obligated to wait for this
	reader.

o	An updater removes X, then calls synchronize_rcu(), which queues
	a wait element.

o	The grace period ends, awakening the updater, which frees X
	while the reader is still referencing it.

The reason that this is theoretical is that although the grace period
has officially started, none of the CPUs are officially aware of this,
and thus will have to assume that the RCU reader pre-dated the start of
the grace period. Detailed explanation can be found at [2] and [3].

Except for kernels built with CONFIG_PROVE_RCU=y, which use the polled
grace-period APIs, which can and do complain bitterly when this sequence
of events occurs.  Not only that, there might be some future RCU
grace-period mechanism that pulls this sequence of events from theory
into practice.  This commit therefore also pulls the call to
rcu_sr_normal_gp_init() to precede that to rcu_seq_start().

Although this fixes commit 91a967fd6934 ("rcu: Add full-sized polling
for get_completed*() and poll_state*()"), it is not clear that it is
worth backporting this commit.  First, it took me many weeks to convince
rcutorture to reproduce this more frequently than once per year.
Second, this cannot be reproduced at all without frequent CPU-hotplug
operations, as in waiting all of 50 milliseconds from the end of the
previous operation until starting the next one.  Third, the TREE03.boot
settings cause multi-millisecond delays during RCU grace-period
initialization, which greatly increase the probability of the above
sequence of events.  (Don't do this in production workloads!) Fourth,
the TREE03 rcutorture scenario was modified to use four-CPU guest OSes,
to have a single-rcu_node combining tree, no testing of RCU priority
boosting, and no random preemption, and these modifications were
necessary to reproduce this issue in a reasonable timeframe. Fifth,
extremely heavy use of get_state_synchronize_rcu_full() and/or
poll_state_synchronize_rcu_full() is required to reproduce this, and as
of v6.12, only kfree_rcu() uses it, and even then not particularly
heavily.

[boqun: Apply the fix [1], and add the comment before the moved
rcu_sr_normal_gp_init(). Additional links are added for explanation.]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Tested-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Link: https://lore.kernel.org/rcu/d90bd6d9-d15c-4b9b-8a69-95336e74e8f4@paulmck-laptop/ [1]
Link: https://lore.kernel.org/rcu/20250303001507.GA3994772@joelnvbox/ [2]
Link: https://lore.kernel.org/rcu/Z8bcUsZ9IpRi1QoP@pc636/ [3]
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/rcu.h  |  2 +-
 kernel/rcu/tree.c | 15 +++++++++++----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index feb3ac1dc5d5..f87c9d6d36fc 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -162,7 +162,7 @@ static inline bool rcu_seq_done_exact(unsigned long *sp, unsigned long s)
 {
 	unsigned long cur_s = READ_ONCE(*sp);
 
-	return ULONG_CMP_GE(cur_s, s) || ULONG_CMP_LT(cur_s, s - (2 * RCU_SEQ_STATE_MASK + 1));
+	return ULONG_CMP_GE(cur_s, s) || ULONG_CMP_LT(cur_s, s - (3 * RCU_SEQ_STATE_MASK + 1));
 }
 
 /*
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e4c0ce600b2b..131fb463ba68 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1801,10 +1801,14 @@ static noinline_for_stack bool rcu_gp_init(void)
 
 	/* Advance to a new grace period and initialize state. */
 	record_gp_stall_check_time();
+	/*
+	 * A new wait segment must be started before gp_seq advanced, so
+	 * that previous gp waiters won't observe the new gp_seq.
+	 */
+	start_new_poll = rcu_sr_normal_gp_init();
 	/* Record GP times before starting GP, hence rcu_seq_start(). */
 	rcu_seq_start(&rcu_state.gp_seq);
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
-	start_new_poll = rcu_sr_normal_gp_init();
 	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
 	rcu_poll_gp_seq_start(&rcu_state.gp_seq_polled_snap);
 	raw_spin_unlock_irq_rcu_node(rnp);
@@ -3357,14 +3361,17 @@ EXPORT_SYMBOL_GPL(get_state_synchronize_rcu);
  */
 void get_state_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp)
 {
-	struct rcu_node *rnp = rcu_get_root();
-
 	/*
 	 * Any prior manipulation of RCU-protected data must happen
 	 * before the loads from ->gp_seq and ->expedited_sequence.
 	 */
 	smp_mb();  /* ^^^ */
-	rgosp->rgos_norm = rcu_seq_snap(&rnp->gp_seq);
+
+	// Yes, rcu_state.gp_seq, not rnp_root->gp_seq, the latter's use
+	// in poll_state_synchronize_rcu_full() notwithstanding.  Use of
+	// the latter here would result in too-short grace periods due to
+	// interactions with newly onlined CPUs.
+	rgosp->rgos_norm = rcu_seq_snap(&rcu_state.gp_seq);
 	rgosp->rgos_exp = rcu_seq_snap(&rcu_state.expedited_sequence);
 }
 EXPORT_SYMBOL_GPL(get_state_synchronize_rcu_full);
-- 
2.48.1


