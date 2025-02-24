Return-Path: <linux-kselftest+bounces-27298-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B67A41356
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 03:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC7C33B3FF8
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 02:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE7E1A3176;
	Mon, 24 Feb 2025 02:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MltGf9+X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E7C1A08B8;
	Mon, 24 Feb 2025 02:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740363743; cv=none; b=sE/aa19PIn2xX4BNbLXxcsQWmuaVVsGt8vluoHiQiTBkmzmwATpQo2NI0O+RfOjJYifIEDaJ2J09tHH2hQJ28h90cfoFZDlmyFRFSDvtmR4oFXc8+OBkeE+v6zSpha73tBwyUX+l2fKrkWyMna+WFnedEBiO9bOR7QTqSGveVMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740363743; c=relaxed/simple;
	bh=Tl0eobmzKFR8IE72hC7Onl6yHZ8FilaP/b+maBCQA8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fz3Cw7M3HRDuh/NQY+6sTHE0wUTcQxJlnIRlyZIsO1wru7weTEzPJNIO747q4c20yWmncHzuRabkFCP8Thwe+yMaUEXOFGnRCT7AOq5THXe6CjUNoRPyv5GMEWmRX7pRPy55V4T6vP81MYWxukfxiHF31wBSWvDPaIjx1GbD3BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MltGf9+X; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c0892e4b19so484888585a.3;
        Sun, 23 Feb 2025 18:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740363740; x=1740968540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D1poumkMbwz8WUDhgcTGwAxfP5yNlPlZcTKSuNaDv0I=;
        b=MltGf9+XcGiqNjM1BPFni22Upfufkq6Vi0EDWNs4hfHR/vYGWf/Bdjb61sYsj8gwaV
         JPpgaYEn62qrEmfkDWxrGyyXyjdyDVchqZyt49mm+7JMaKqJ8BBm5w48Pb95J7LChrvv
         iExHsbmZUJqE792IKfdVxrLccq8c9hfqojX55iQYadYfy+vMvQhWMqOaOTTDrL+boZ2x
         Ao4F4A9Mt4DhVZ5DgfXloIVaw9Vz48smlviMSgwbYvuUh1C7cBe+nIVd0iHUsrvhNyqs
         pMW9N468LBvESiosj9gibkj/xRmptqjpTohHXRe8mnpo5H/2rrzX/izC+PCGC3CN4n/Z
         TQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740363740; x=1740968540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D1poumkMbwz8WUDhgcTGwAxfP5yNlPlZcTKSuNaDv0I=;
        b=LadNns5EwlcH2KWeG96IfZMAJ2QSdmMtbkDzhxs4n9qE51/xDa/HPElYsAjaZUTLEE
         Xv5/8DLHfHHHUCFeHKhA6eTlP6mQeBdO8G73/hkrXgV/XKPSSeTIVyN5zovIEJM4fHS4
         ShjD0GP+swMEZ0CuTeBuxCziMVLwqU4Tt7fFoEe5EGuwPEGqrb89bE7JCnn6QPZyKm4I
         AZSJUIVsa2f50xagswtbAmNK3Y8qJ/yn0Zr/DVuOLHDioDCO37MVfBppnzGUr8FtnS5b
         vLXGOZAa+vBBGeBz0gB97sjVOWP9jNZfwUAW3apvwSS+r0B6dOWzgVVCC57LFk3EKNf8
         fRoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWhhEPPjF98DI4O5iN/q4s6T8Tm2Cb2QZj6dR8lqS+Vk/c3xkYbZ2Ty+K1/HU8Ixm+O78=@vger.kernel.org, AJvYcCVaq+sMkKIV15Q0rCrFFyo4kWz/StQ9jsmwNe1I7uiNjc40eEakjO+Bl9abJK2q2bQ0sQrmK8yglHEEAnRo@vger.kernel.org, AJvYcCWVkl8HGdMyo0iVP9YGHPjT5lazk10VGBAygMWze8L7SuAvTb4SwIY0MTT+pOkj3Dtyu6Zz0iIleQfr2v+L9NjH@vger.kernel.org
X-Gm-Message-State: AOJu0YyyaNXKFbowWH+NJxEeoBctGe2aWb6RvPuB43wasS+vIZxyX1yL
	sm+ePgCeeiJ13sq1Xysg3p3fjMBqL/TMtDYDdi9lOrf9mAo6FHqs
X-Gm-Gg: ASbGncvooaTYHaEj5f8OYWsBQcy2R94dtG9/8Kx9sh4lL6Ng7x43XGLQo4LK++2lqiX
	xdiLk9xknXda/6Dcu36hmPiUCAYt3+Goy0D2armR4NyZR+8yijc2ixLfEpbaBzZZrGfw3f7gB9p
	/nEo7W4jeq3gXMc9xoklVNpfD74kBBHfuleAVHyIvLYOIb4iH76NjgSmtEFNUjoiRqHwQf+oUSa
	XsTVLLJ6A3SHLZZWj7N0wdlWOX3Ua/QbruO4IDA4zzHErUJ8onauExqO419kaqqloj7UgWRKyqG
	ZckyIBV+TEc/p6oR5H8wqdIQFLBMeqH7mecpvEzGXJsIJGUbiSxYVfbpye8N6KbnE0LQUInwGSN
	rdIfjcGJdzn3xTdGM
X-Google-Smtp-Source: AGHT+IEbG51k5BQfXyudC0joXeQ0yrs56uBl53PyH/gx5UidLvBI1pZnngtdFjGKW1kJtA5lDdnEOQ==
X-Received: by 2002:a05:620a:4113:b0:7c0:a389:f23c with SMTP id af79cd13be357-7c0cef7a394mr1888342285a.49.1740363740269;
        Sun, 23 Feb 2025 18:22:20 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0a609cb1bsm856081785a.111.2025.02.23.18.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 18:22:19 -0800 (PST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 58A4F1200043;
	Sun, 23 Feb 2025 21:22:19 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sun, 23 Feb 2025 21:22:19 -0500
X-ME-Sender: <xms:29e7ZwN1i7Uuf5xKhYzD7bfnpNIb820Z9e01t9j3k4dSQ7p_ZbO9sw>
    <xme:29e7Z2-gO1hBAaCW81h8z6z1c1DPwO_PQdmu3jw7ZoJQXZWV4hi-XA2SRbjiifiz6
    XK5GcjFDHiuOszQoQ>
X-ME-Received: <xmr:29e7Z3RhO0MU34XePgIuSzUIbdbItc-YXp7RDkcIc0WylQ2yaihovITKcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejjeehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfev
    ffeiueejhfeuiefggeeuheeggefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvvddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehjihgrnhhgshhhrghnlhgrihesghhmrghilhdrtghomhdprhgt
    phhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhshh
    esjhhoshhhthhrihhplhgvthhtrdhorhhgpdhrtghpthhtoheprhhoshhtvgguthesghho
    ohgumhhishdrohhrghdprhgtphhtthhopehmrghthhhivghurdguvghsnhhohigvrhhsse
    gvfhhfihgtihhoshdrtghomhdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepnhgvvghrrghjrdhuphgrughhhigrhieskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepjhhovghlsehjohgvlhhfvghrnhgrnhguvghsrdhorhhg
X-ME-Proxy: <xmx:29e7Z4siqq34lMlEx5rWLYsOVUmn10eTvBSF8SNMS0A1bifHBfplxA>
    <xmx:29e7Z4db4WpC2GRyYgWH3HYdsIpIzhj-LEwP5K4QOJIL1bLnBZM5jA>
    <xmx:29e7Z83eie2iDWg19TBVHy3nLW54gaZztM6f5Tg3gFaFEVIMmuGcjA>
    <xmx:29e7Z8-ceZ8EnKEwaLrV3wpNdXcuOP8Rkva-iFmti8d0GT3BxFQzhg>
    <xmx:29e7Z_-KLkPE44EtuIuI5lrwXfW_TCyFR9nXnI5_K0ZMK7EFQ4tzJX01>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Feb 2025 21:22:18 -0500 (EST)
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
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH rcu 02/20] srcu: Define SRCU_READ_FLAVOR_ALL in terms of symbols
Date: Sun, 23 Feb 2025 18:21:56 -0800
Message-Id: <20250224022214.12037-3-boqun.feng@gmail.com>
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

This commit defines SRCU_READ_FLAVOR_ALL in terms of the
SRCU_READ_FLAVOR_* definitions instead of a hexadecimal constant.

Suggested-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: <bpf@vger.kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/srcu.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index d7ba46e74f58..f6f779b9d9ff 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -47,7 +47,8 @@ int init_srcu_struct(struct srcu_struct *ssp);
 #define SRCU_READ_FLAVOR_NORMAL	0x1		// srcu_read_lock().
 #define SRCU_READ_FLAVOR_NMI	0x2		// srcu_read_lock_nmisafe().
 #define SRCU_READ_FLAVOR_LITE	0x4		// srcu_read_lock_lite().
-#define SRCU_READ_FLAVOR_ALL	0x7		// All of the above.
+#define SRCU_READ_FLAVOR_ALL   (SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAVOR_NMI | \
+				SRCU_READ_FLAVOR_LITE) // All of the above.
 
 #ifdef CONFIG_TINY_SRCU
 #include <linux/srcutiny.h>
-- 
2.39.5 (Apple Git-154)


