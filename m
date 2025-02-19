Return-Path: <linux-kselftest+bounces-26987-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCECA3C3CD
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 16:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D64A165F7F
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 15:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B851F9421;
	Wed, 19 Feb 2025 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFBW21lC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134FB198E81;
	Wed, 19 Feb 2025 15:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739979585; cv=none; b=RaoXrvGo8hq23G9pmfOCCRx+12bSOnS+NauV6JtWXhgj7hW0g6ATFGx8mqazAJx57GEd3Z4dTMn3heLPxjNrLZky0nXYsarPXF+jJSfiTWJqQY9v6MZqXBXZAcOfJ2qMWjQde4pY+Y9O+rz3pCaHfGpNq2xuUz8CKc1Yl05b2C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739979585; c=relaxed/simple;
	bh=gOBJQr57HVai1YFd7Xm+S8zGKknWTzs5SQGe41z1lOY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VqfIpUMXa4+QIq7MEvKOo7DR9miJP1vQRiEN6zL4VttT8yIXxMxUpRijkryU6uf7zVRCKBu5bzvwXMI+2Gc4RfVqoANNcS7PIQdQXQCfG2pWgcJhWle+ivTk0JBr+2U1t6xKzFIhS8E/A7A/xjSThZJUl/NCV/Ydvl4aASNS8pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFBW21lC; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c0a1677aebso278760885a.0;
        Wed, 19 Feb 2025 07:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739979583; x=1740584383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QOPQIn1fX7GxNW/Oq7e50z1baZmFRs2en+1MYVm0Jko=;
        b=NFBW21lCXm9CbR81Gum2qoGNYd+hry0EojUdsQC84hMSbg3aqFocCRMFmXMVMvojjf
         CIqzpm10T9o5l5JmlZ1pTwrLu4PLZ9Tr99jYDaYZ72mcxnG6ZIAWqKgzeirB65cuc6Qn
         K8stk3ES9XZpQLcjpaMDfNPPjobYOCqeO90CJg6/hRmKQ3JZI2vDe1qElNJUYlxyuQNx
         ZbW2OS6+WdCtAfWwdh34Kt35ktI3NX9GcbNccAXkcGlm35Z95O4nvzox4mFC2p39VcYP
         B6MoVmjVLyRdTUXQko642USlixBFiDlh5SHVF7ISMHpeqXH4tPNW4g1mjSompz2wtydy
         vt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739979583; x=1740584383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOPQIn1fX7GxNW/Oq7e50z1baZmFRs2en+1MYVm0Jko=;
        b=anczp1E7AsvlKm6q89V3Ae1i+t5bbZFF3q9Gbb4kmhYn79SQsR8Obf7s1OXj4KnPOt
         xfEdIh0vn5bquOikzmF/a+A2k4CYZVkzmwo6YQ8QxVm3VeJcWiUhBRUNAHvctiqsCOpA
         7crRX1onDMBfEAn6lLaG+lcCRq7uNWk1uH2sIDzHZyAyppsV9NRq3O6/PBkTADfuqArb
         ja4aMlCvR9MncoFME96HVr1H+11fWYshfTMO4+MuLbFJFSo/R2WEPya+L56wjieDp8Hg
         ofQdIbtWxlFU0q1X/wHfGanSsGpjOh+nhG7nDW3drx1M4hllzkyHAiuTJVjYbHR+GskO
         o+HQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7+ttoQK/z/cMODARS5rp2eQQj2tWemrxkb5DeDn6zgEj2drwkwkC1Kt0diUbc1VAZXmRhpy2e/9AHA+vjp4ywKRFW@vger.kernel.org, AJvYcCUe1GF1r8+g8H9GBctpycToFM8c2Asj4VMTfccPZxM6R1Qzu2yPZGTYBABmEkYvQoD5vgARdBNN/sQ=@vger.kernel.org, AJvYcCXGekreKnEgwPLPQSlNvv1sSYOjEkxNp9jW4hI94Ee8Osbh8ZfasEnbHomNRdO6Me9QFb39oHXvPvIuVe14xmub@vger.kernel.org, AJvYcCXo5+4x3Ln/T2ufPUxxH4OGNVfFtimKGNYzlHEN9BnbJAJrDQ/WnY4J5ykF8A5N+a7hZEPpB1qyr9poyRde@vger.kernel.org
X-Gm-Message-State: AOJu0YyVXBD8pjYrMxRCbuKlrDudewy368WRpVy9cxQLKuRtavwXX8a/
	I8CXwEfLTD/lExlXHBikSvHRJP9n7Vu8YH6Q9hsfk+k8B/uofA0g
X-Gm-Gg: ASbGncuForHTIK7Qb6H6NrJ3wx2MA39lBd+cLJIu49IHjYBOrtryjZZDkF0wdMlp54d
	tH8OXRFl8uE3XeQNgplhbcssoxsL6lo2Ml6MBkSo6KemXP1O4J4k/7WLEUJEWYeyjHTnnrkoYqx
	xN5GGtlC9DmXoiKw3C/habEnjY+wko0/U3IvlVhXe74+nq+HD+/y+jqS/YEISAfUWBj2m1VJGFB
	dad1ZI9piruWoOKTqAczTdh+eAzvxTh0iq7pfIW+2WN1ENN0fdNJ+b9cv5/mc/bQ7iycJ34bF8u
	DzP8IhNT1fmvihq/zyaM/W2kx9lfqMPyO3h09FPyRbmo4VuNVWMGrup19t0mFMJY7VuZLPEPoFa
	qPEOCFg==
X-Google-Smtp-Source: AGHT+IFzvAL5bAZmO7McixMnJtBdygccmJwnnXWUeAxB4tYPWT6bakDwtgNas5txE5kws5pwrRm0PA==
X-Received: by 2002:a05:620a:6007:b0:7c0:ba6b:b6d2 with SMTP id af79cd13be357-7c0ba6bba2bmr259913385a.38.1739979582828;
        Wed, 19 Feb 2025 07:39:42 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0abde9fa0sm233481185a.105.2025.02.19.07.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 07:39:42 -0800 (PST)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8EBEE1200043;
	Wed, 19 Feb 2025 10:39:41 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 19 Feb 2025 10:39:41 -0500
X-ME-Sender: <xms:Pfu1Z_9mOZVtSQlDGI4OZflKd6QOxIceB0nV4d3dPgJC1rRDWcntHA>
    <xme:Pfu1Z7sQBHkepvrr9SmSFjU-d7AT21r2etUgfqWGZriP5Ny5vY5Y9HpfeMqTahVLg
    g8d-x6z7KTYddspng>
X-ME-Received: <xmr:Pfu1Z9B5h7vUujka9GGhE8Bf3WhGUVXJHeSmDGfHYCX9kIfllo-G8Lz-NA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecu
    hfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtg
    homheqnecuggftrfgrthhtvghrnhepgeegueekgefhvedukedtveejhefhkeffveeufedu
    iedvleetledtkeehjefgieevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhm
    vghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekhe
    ehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghm
    vgdpnhgspghrtghpthhtohepvdekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hrtghusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghorhgsvghtsehl
    fihnrdhnvghtpdhrtghpthhtoheprhhoshhtvgguthesghhoohgumhhishdrohhrghdprh
    gtphhtthhopehmhhhirhgrmhgrtheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgr
    thhhihgvuhdruggvshhnohihvghrshesvghffhhitghiohhsrdgtohhmpdhrtghpthhtoh
    epphgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhrvgguvghrihgt
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvggvrhgrjhdruhhprgguhhihrgihse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohgvlhesjhhovghlfhgvrhhnrghnuggv
    shdrohhrgh
X-ME-Proxy: <xmx:Pfu1Z7cpw4Bu6SWvRSIB59oWNQCspdHG_i7TfaqabHWq4vhlHNiCFw>
    <xmx:Pfu1Z0Pxio3WCXYf3Sx3PV2KmeQ62kelDYSrFEf-aJ-Oky1Iw3LJgA>
    <xmx:Pfu1Z9mHlR3mAQmc8Qt6Ec9foVre3KXoKz2PNpHUNqJgjHVbWLPGrw>
    <xmx:Pfu1Z-teYc2WLpoA8InXfuhgV3ST4LZv-sgibucN97rb1-0gZOev2w>
    <xmx:Pfu1Z-tYEUEP1VinV0deYw632B4GKoB0EmNNXPDTxMk1Cnru0V03hWcL>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 10:39:40 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: rcu@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,	Davidlohr Bueso <dave@stgolabs.net>,
	Shuah Khan <shuah@kernel.org>,	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Huth <thuth@redhat.com>,	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,	Yury Norov <yury.norov@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH rcu 00/11] RCU torture changes for v6.15
Date: Wed, 19 Feb 2025 07:39:27 -0800
Message-Id: <20250219153938.24966-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Please find the upcoming changes in rcutorture for v6.15. The
changes can also be found at:

	git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git torture.2025.02.05a

Regards,
Boqun

Paul E. McKenney (11):
  torture: Add get_torture_init_jiffies() for test-start time
  rcutorture: Add a test_boost_holdoff module parameter
  rcutorture: Include grace-period sequence numbers in
    failure/close-call
  rcutorture: Expand failure/close-call grace-period output
  rcu: Trace expedited grace-period numbers in hexadecimal
  rcutorture: Add ftrace-compatible timestamp to GP# failure/close-call
    output
  rcutorture: Make cur_ops->format_gp_seqs take buffer length
  rcutorture: Move RCU_TORTURE_TEST_{CHK_RDR_STATE,LOG_CPU} to bool
  rcutorture: Complain when invalid SRCU reader_flavor is specified
  srcu: Add FORCE_NEED_SRCU_NMI_SAFE Kconfig for testing
  torture: Make SRCU lockdep testing use srcu_read_lock_nmisafe()

 .../admin-guide/kernel-parameters.txt         |  5 ++
 include/linux/torture.h                       |  1 +
 include/trace/events/rcu.h                    |  2 +-
 kernel/rcu/Kconfig                            | 11 ++++
 kernel/rcu/Kconfig.debug                      | 18 ++++-
 kernel/rcu/rcu.h                              |  2 +
 kernel/rcu/rcutorture.c                       | 65 +++++++++++++++++--
 kernel/rcu/tiny.c                             | 14 ++++
 kernel/rcu/tree.c                             | 20 ++++++
 kernel/torture.c                              | 12 ++++
 .../selftests/rcutorture/bin/srcu_lockdep.sh  |  2 +-
 11 files changed, 144 insertions(+), 8 deletions(-)

-- 
2.39.5 (Apple Git-154)


