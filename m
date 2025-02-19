Return-Path: <linux-kselftest+bounces-26997-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA96A3C3EF
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 16:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76283179506
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 15:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A09A211291;
	Wed, 19 Feb 2025 15:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N94fRg6+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CBA20DD47;
	Wed, 19 Feb 2025 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739979602; cv=none; b=sEylaaa5Leyk83EIfde4OqyB1leW/l5CwISY4AaVF7F1co/1oLNmJpebZe5HpV8/a4bmtDXbJQiYbYuD9fsI0DGd/B1fAqkSC06xxvcfAXospyJqJJoWBk08jisYkB/UzbFxoF4EFOZ78S3yjoKow75ilgzcTEMd5pXGaE8o+MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739979602; c=relaxed/simple;
	bh=an4KNHVs7gSBs358oGs1I8t+1NBNXJX13KJvWnGXIAk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pZ7N+9ID/eM0uoiEeam4mJqVw2r9Cb4xpdFTHR6msxA26GCj92v2ULlKovb4ezIydIqAYLt2L6c0LZvKeSiQ6CS5OVliLI1unR8KaBhp/X9cofrZGQrFxblvGb/N3HjgxgiXl9xl8PREqbRFuPN0GPWfkTKJAq4oYOcR6Bduk9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N94fRg6+; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e1b11859a7so33079226d6.1;
        Wed, 19 Feb 2025 07:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739979600; x=1740584400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MzOBUseEPtSLy1MY8XLSjvwliFukGnvj57FomDjcylc=;
        b=N94fRg6+i8W435YpfKJEqWUvFjtbmRk2Rs2qUDBXR7Rj1g3FN0fVUpSFocz4nzjBUB
         QCm5maEK9ViJaxmvPGNli+FTFUzQ7gnXwMKGdM2dqrSCgYOtlODUF7dX2hGat599rLdl
         1mn5PHdy6vdz+NaP7XyAILzYRGtT9cytX+qi42rxsTkFNMVJUFv3mZWIzT2OuO5exT4j
         K0TigGNAJRzH7zhyjNXS6B1LW0SKRKvWA0B8sRxlaTAbeL0yrbL65lgHYPPcPLIMwkmD
         NNFau+Fx7yH7SPadsusOa0BFmKNlfUd6kLs+Q41gn0yXVtQyLBp+C5CYO1wAILvAHWBK
         ztVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739979600; x=1740584400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MzOBUseEPtSLy1MY8XLSjvwliFukGnvj57FomDjcylc=;
        b=ITY7yijfzH3zY6j9lK6RpTL7cWyZb09kEF6r3S7nmyNJuKSOSeHFUxuQfHab0Ll4tT
         SKpUyoE2K74FzmfDUGYAu7987luqrKvT3s4O5FgJMdd7dz4BDsGhqoK274QzKzOA6JBj
         VZwlBRppXE2FDiL/WFdpFTty/ujw82blyFPQygwQArw3KBdfgBmaU7r7nVPwrXXc+K7T
         M1l2R6fPlzQxif1bxtG7a+Qtb53wyPqWWJLqoloPgdaFS7dbqCCrhUGKN+m6tQDFvTvT
         fLW7XHlbZqdlY2LC73ArEW5AdDc+Bl55Epy0WjeutJmCTtob941JjlbVvuNCcDk7H5n2
         DSxQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4c8vQBhjxPvIiml6/OE0J99Fd4+bFQFdJhSdmOblRdHmI/GaCdYE7DcuzTPiIJGk+eblsfKWXw8UY7ewrLnF5@vger.kernel.org, AJvYcCW8AY4jMEZ25g4a3MKDXlv1eAJhwevMj7H0b6x8IyccoewgV+XHOzA2S0SjUIbk17AM7kPoJN/3wsXH+Q5G@vger.kernel.org, AJvYcCWEBgbv6cTicDc6sZT7ptc/wXc433wBGzXInq6fU++AQDptamZjeAFkbcHgPno4Jc/qOk4rfz5reQg=@vger.kernel.org, AJvYcCWTyjNEkLNySk2rUlCgtNcBmQPh2slmoIjegPP4VlSpSiWBnrsRGRLOeVQMPfqSsLzCPkFkokNxWYYjKLFjXFRtJDTP@vger.kernel.org
X-Gm-Message-State: AOJu0YzgfBBXg5US7EmoehRjxm6wyx+CWoS3QnRqIcy6Up+d83li3ope
	QSUXJpfBpdf18N23LiY+1FYWytrM7GPzdT0kgUoCj5tx1g/iNGyz
X-Gm-Gg: ASbGncsaVhgT+sTluW6togX57Ner5qlEmTWRvK8acHAEIe5wR7D154DRtbeMJnAELbW
	NwH29e5Z2BpzsUC/ZpIikAvCnuelYRCN30LyqlFnYuNbLG4fjT9QjP7wwvYivDTWOFOQE/Uuym9
	zG5DgfuSEcqUP3Bwnsh1KX9CvPuPcF8AImA74KHGoSz9Uandmlxz7X6MnxnPZxLd6qE+P7LEsvo
	sQOI9oOilZsCw0zxmdpbXhUWuBmRsC6cFyp4vlI4ysixwKnbLfSaWypgrBBvBnNUKRpfBXR3LIc
	zxAPuGbBUDxgDyqtoT54POK/GzRNJvUrlPt15oSZqkmRauUBEz1JoskrSI3ICcMgYa7UY6N/a1I
	y2I5xxw==
X-Google-Smtp-Source: AGHT+IH12jU4YhpRnLVfQ11bY+OVBpdhfdR4QC4W6UA+cHY6CnmFW3ohEB5EcgIHyHJoYltfKlvXRw==
X-Received: by 2002:ad4:5ae4:0:b0:6e6:6c7f:111a with SMTP id 6a1803df08f44-6e6975bd236mr59780676d6.40.1739979599637;
        Wed, 19 Feb 2025 07:39:59 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d785b17sm75598206d6.45.2025.02.19.07.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 07:39:59 -0800 (PST)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 90D6F1200043;
	Wed, 19 Feb 2025 10:39:58 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 19 Feb 2025 10:39:58 -0500
X-ME-Sender: <xms:Tvu1Zw2IXq8ldDw0s7rTN-lHA_kK2Z2z-GJRIBoMOhsLPvh9oNAagg>
    <xme:Tvu1Z7G3bZNeP5EMFLMcK7_789qVV2kpxU-WmvwPZ5Quc8S2iJ5LDMotdl9l4CnoZ
    fv2c3Be4MxDVfxY_g>
X-ME-Received: <xmr:Tvu1Z46UTCUu4y1LIHWK4HepWTDh5_50rbIEUSuSXBlRt4ftgfii-krAQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfev
    ffeiueejhfeuiefggeeuheeggefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvkedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopehrohhs
    thgvughtsehgohhoughmihhsrdhorhhgpdhrtghpthhtohepmhhhihhrrghmrghtsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehmrghthhhivghurdguvghsnhhohigvrhhssegv
    fhhfihgtihhoshdrtghomhdprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepnhgvvghrrghjrdhuphgrughhhigrhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epjhhovghlsehjohgvlhhfvghrnhgrnhguvghsrdhorhhg
X-ME-Proxy: <xmx:Tvu1Z51A3gql951xWR0ccCEq6Q7AQSkByYh9_dFeuX1siRhtMO7cDg>
    <xmx:Tvu1ZzFVrkFPUXmcXfg61SFJtt8Wu0jAxpeMGYAKB6fFJ5W8UfAHxQ>
    <xmx:Tvu1Zy_o1h_FyiZdiKRnpjgFroZ4rnvnPRnGP2H8vRpq7ivL-0tlGg>
    <xmx:Tvu1Z4mnDOMtqB5SC12ERyL9Q2r3nF9LGaYZzMDn7WdfF4zTAAaiXA>
    <xmx:Tvu1ZzE45VPn88HV8BcN_YTpfBA6tTlbV3usIVe1pTz0FJb4ObeZBUkE>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 10:39:57 -0500 (EST)
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
Subject: [PATCH rcu 10/11] srcu: Add FORCE_NEED_SRCU_NMI_SAFE Kconfig for testing
Date: Wed, 19 Feb 2025 07:39:37 -0800
Message-Id: <20250219153938.24966-11-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250219153938.24966-1-boqun.feng@gmail.com>
References: <20250219153938.24966-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

The srcu_read_lock_nmisafe() and srcu_read_unlock_nmisafe() functions
map to __srcu_read_lock() and __srcu_read_unlock() on systems like x86
that have NMI-safe this_cpu_inc() operations.  This makes the underlying
__srcu_read_lock_nmisafe() and __srcu_read_unlock_nmisafe() functions
difficult to test on (for example) x86 systems, allowing bugs to creep in.

This commit therefore creates a FORCE_NEED_SRCU_NMI_SAFE Kconfig that
forces those underlying functions to be used even on systems where they
are not needed, thus providing better testing coverage.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index b9b6bc55185d..c8e540af3a35 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -65,6 +65,17 @@ config TREE_SRCU
 	help
 	  This option selects the full-fledged version of SRCU.
 
+config FORCE_NEED_SRCU_NMI_SAFE
+	bool "Force selection of NEED_SRCU_NMI_SAFE"
+	depends on !TINY_SRCU
+	select NEED_SRCU_NMI_SAFE
+	default n
+	help
+	  This option forces selection of the NEED_SRCU_NMI_SAFE
+	  Kconfig option, allowing testing of srcu_read_lock_nmisafe()
+	  and srcu_read_unlock_nmisafe() on architectures (like x86)
+	  that select the ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option.
+
 config NEED_SRCU_NMI_SAFE
 	def_bool HAVE_NMI && !ARCH_HAS_NMI_SAFE_THIS_CPU_OPS && !TINY_SRCU
 
-- 
2.39.5 (Apple Git-154)


