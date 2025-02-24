Return-Path: <linux-kselftest+bounces-27296-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDB4A4134B
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 03:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E560416E4C1
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 02:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714BC19DF41;
	Mon, 24 Feb 2025 02:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6CMQzLW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74A2156C5E;
	Mon, 24 Feb 2025 02:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740363740; cv=none; b=VPrCCqPtqX2NFm2pPqArhMaYP/gezFP74/85iquETW0wSimf9T1/RdSEZtht7SiQBCScos7wljgvHBniPptlb/y+bzMmQC4acd663QCPi6WrN5rinNORKVJZ1eBERmHFchiTSw9UacF/kxRLjI7rLNWraJ/nKAvqF8OcLxZlcno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740363740; c=relaxed/simple;
	bh=jI7ZO3NuOHCRGWYIkk0Ep38pgswb06/96+GrIdTvQ4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RSXV183ao5YsrqVditQdWsAPSUz7OCRIcL1IlFaNxCVZPta5O7bU0WqFMnIOI5pUcD/VFCEiRuOg02PAQvRs1E0NfWeXypvc8e9KzEqH4mm/p/wPL1hFK7T4Icphhn92tjKKNcWNxNqE8XLcRT+1GOYj4Tys/JZlRPSz8HnJaII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6CMQzLW; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4720fb0229fso38679291cf.0;
        Sun, 23 Feb 2025 18:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740363737; x=1740968537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yrrPZ5ryMu2bp7LE7X5PSIh2Y8sPYdQgIhsVTV+ySuY=;
        b=N6CMQzLWVAHKh9cVMFjYadYQI0WVbwHpfywJUiMfIc3nNGxn+WIVgACx8zEYQqh/Ms
         ZLpOuLGRjpp9NenDqyjEL7uykmsiizEIlF9G3AxDM1bCHE9uA4ploSove3t9XJEYskPL
         auF/+C2qJ1LHCfE4den5IW5QF5Oug3zrZTSHibtwQDG5xmILsmeNeEugSvkf6mBLyD3d
         1+trSmE3vQRLrGaidt1PuM8dtUqp2bTNrkagO4k/E1o0I5IqM3RYuq0kU7eK/5dwQKsd
         SeSUrgYccnEdi9eesVd+r+Vn13VQrvsUEwpuLdaRnc7xSl6Xwo/crJEmR5GRGccC41OR
         qjtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740363737; x=1740968537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrrPZ5ryMu2bp7LE7X5PSIh2Y8sPYdQgIhsVTV+ySuY=;
        b=nu++0d+TZRbcrFH7YQyq2KRytRJM7I0K2BW1MEg33GqZYu0Y+sN6gKQW1dwVTh5Swv
         /cOVaRqKQcid6jC1beagUW5Z6hhCKOFO9kLJcgnoDhUUd70gYIisXqSsraTPWdDeT4AR
         wbNueRaHV9gGFhJnOTsC/frLwzixbVcaC2fhGxKtz9ERPZ2JpCDQM2yiScjqTXCvrTBs
         0K1uEAy7YbnsD5i2B4zo2BWu/oH+83dxcHzA022kymTm3F1ugcJ3/cldMofKsJBpTpzT
         hyx/tiV++g4rN5WfXhmaWnyPGWSQhaWaQnPvwdX4HJjEg+DJO8xfPhStAXr/TJ7RKnCv
         1vjg==
X-Forwarded-Encrypted: i=1; AJvYcCUfHbJRnjjL5gdzVSC8gflAkNL10i0NiTArqay3CGHW4VQz9NEXrkjx5SGnx1c70AWdaUg=@vger.kernel.org, AJvYcCWipnMUtjQTEVJ7xP/nLM8FaJcDQNkjxoopOnhe2zbETZ0QHvtztdtpBpjaMrjtIbwecfORzerkFup29nPD2N6i@vger.kernel.org, AJvYcCX+pZSTOOMIcwg1a2tFnsV1wm/9GtrIwhwvFmFvsbFYStiwbQXfBQzrFAGxQtWKBKwvzXcjWxMyIKm3+wPd@vger.kernel.org
X-Gm-Message-State: AOJu0YxqKeKduos1Q++uzz+zj461bF1+SWHzAeomfnYdTeKCrL5cI/Ym
	VLnNrZZtlMGA3FeEzL57DGFjDZTk+u7LbuqPaT6levtxsyWn17j7
X-Gm-Gg: ASbGncsgPc4IgUUBd/I/jowJ2C5C0Ypi9JInCvbccTLqN1ALZgc/jvF6FGEvKp2Exjf
	T/cEBxRMK91y+IyGzBSvW348oMfxbLcCQEXWryejLKZwOT4NgMUoVrNcIo3olBy0t3lqtDisVL8
	Y7ubbdMLNCQ3OkdQQCpsHYiJv2/mURrCNlWQueyeehKxXDPWOTHXdy7djB4uzK0hLTo0AUAX3fY
	bRjFba9wclWUIdNNGkEZd9VVcsp3p+HjFMtU51Pz9Vmv633dSgtVpxPjUCPmK4be5bnEjm0sS7Z
	ySlGJDtMWnB7FGNHGrSauP47tThJX0kaUuxRKQkubkl9vJJxtoWgB6j/1KXHhPOWcSmrq81qZA5
	NyfokcyjHc9RkJH8F
X-Google-Smtp-Source: AGHT+IGbFJ39dCWO0ABqeYWexGOEycpbdMZZOM5vbZdVCayF52Cae7jcBD3iqERUhW2/PRwEe6VJmg==
X-Received: by 2002:ac8:7fd6:0:b0:472:bbb:1bab with SMTP id d75a77b69052e-4722485b110mr115913581cf.24.1740363737556;
        Sun, 23 Feb 2025 18:22:17 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471f41b78c2sm83981211cf.67.2025.02.23.18.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 18:22:17 -0800 (PST)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8DB411200043;
	Sun, 23 Feb 2025 21:22:16 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Sun, 23 Feb 2025 21:22:16 -0500
X-ME-Sender: <xms:2Ne7ZwcwTb3JBTVuHFFLyDIhV_8WWtqj0DlUn-p2Wiq5ATpTOTlyEg>
    <xme:2Ne7ZyPZbZOLHNbcw1nYb_dK_DU85c0vfVLXPKLoBU3lTeLPGNvgwFlv4HKpLOcAr
    nG6YMH-Ca-0q6EAFQ>
X-ME-Received: <xmr:2Ne7Zxg-f_TYycKthZZ75DaKLWX4nR16sgwa5DTmgBOlthzx3H_kbJ_zrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejjeehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecu
    hfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtg
    homheqnecuggftrfgrthhtvghrnhepgeegueekgefhvedukedtveejhefhkeffveeufedu
    iedvleetledtkeehjefgieevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhm
    vghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekhe
    ehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghm
    vgdpnhgspghrtghpthhtohepudejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hrtghusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhirghnghhshhgr
    nhhlrghisehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepjhhoshhhsehjohhshhhtrhhiphhlvghtthdrohhrghdp
    rhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrdhorhhgpdhrtghpthhtohepmh
    grthhhihgvuhdruggvshhnohihvghrshesvghffhhitghiohhsrdgtohhmpdhrtghpthht
    ohepfhhrvgguvghrihgtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvggvrhgrjh
    druhhprgguhhihrgihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohgvlhesjhho
    vghlfhgvrhhnrghnuggvshdrohhrgh
X-ME-Proxy: <xmx:2Ne7Z19s-r6Ol3gRs8bDeMRUiCt3J2sPlaNbOB4TLh8w3sR91o7OzA>
    <xmx:2Ne7Z8tC1dOyEZvG2fbBopdZJtQqsCnDpMIes9qv1t_hVGBGI2Q3yw>
    <xmx:2Ne7Z8Fu2ukd4duHy76xEYkHrXB8jrytkNi0m01VnItwr-XbUOgHxw>
    <xmx:2Ne7Z7MfDLwK1hJ3v6SSXlKDLi48y6LqnLqqsuBjYYotsBX60qONuA>
    <xmx:2Ne7ZxMeWXEQw5fod255jMAgPBWeUfKDKAmy_Lcihspw9QOXlCkQQ63_>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Feb 2025 21:22:16 -0500 (EST)
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
	bpf@vger.kernel.org
Subject: [PATCH rcu 00/20] SRCU changes for v6.15
Date: Sun, 23 Feb 2025 18:21:54 -0800
Message-Id: <20250224022214.12037-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Please find the upcoming changes in SRCU for v6.15. The changes can also
be found at:

	git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git srcu.2025.02.05a

Regards,
Boqun

Paul E. McKenney (20):
  srcu: Make Tiny SRCU able to operate in preemptible kernels
  srcu: Define SRCU_READ_FLAVOR_ALL in terms of symbols
  srcu: Use ->srcu_gp_seq for rcutorture reader batch
  srcu: Pull ->srcu_{un,}lock_count into a new srcu_ctr structure
  srcu: Make SRCU readers use ->srcu_ctrs for counter selection
  srcu: Make Tree SRCU updates independent of ->srcu_idx
  srcu: Force synchronization for srcu_get_delay()
  srcu: Rename srcu_check_read_flavor_lite() to
    srcu_check_read_flavor_force()
  srcu: Add SRCU_READ_FLAVOR_SLOWGP to flag need for synchronize_rcu()
  srcu: Pull pointer-to-integer conversion into __srcu_ptr_to_ctr()
  srcu: Pull integer-to-pointer conversion into __srcu_ctr_to_ptr()
  srcu: Move SRCU Tree/Tiny definitions from srcu.h
  srcu: Add SRCU-fast readers
  rcutorture: Add ability to test srcu_read_{,un}lock_fast()
  refscale: Add srcu_read_lock_fast() support using "srcu-fast"
  rcutorture:  Make scenario SRCU-P use srcu_read_lock_fast()
  srcu: Fix srcu_read_unlock_{lite,nmisafe}() kernel-doc
  srcu: Document that srcu_{read_lock,down_read}() can share srcu_struct
  srcu: Add srcu_down_read_fast() and srcu_up_read_fast()
  srcu: Make SRCU-fast also be NMI-safe

 include/linux/srcu.h                          | 102 +++++++--
 include/linux/srcutiny.h                      |  27 ++-
 include/linux/srcutree.h                      |  98 +++++++--
 kernel/rcu/rcu.h                              |   9 +-
 kernel/rcu/rcutorture.c                       |  11 +
 kernel/rcu/refscale.c                         |  32 ++-
 kernel/rcu/srcutiny.c                         |   6 +
 kernel/rcu/srcutree.c                         | 199 +++++++++---------
 .../rcutorture/configs/rcu/SRCU-P.boot        |   1 +
 9 files changed, 359 insertions(+), 126 deletions(-)

-- 
2.39.5 (Apple Git-154)


