Return-Path: <linux-kselftest+bounces-26995-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCF2A3C3F0
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 16:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 767653A28B4
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 15:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0444C20C000;
	Wed, 19 Feb 2025 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQ+39GUp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DBE2046AA;
	Wed, 19 Feb 2025 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739979598; cv=none; b=E4gIBmLoNGaI9Q402TRSwZnuTYBV0rE4xYSOHnMxJ3dM7IuxXHByjiRMTf9SdtjSNDBxgVB6ARfRNYPSByKjO3YwHoqSycpH4Qs5dEuYGG3vb7dRI2ickrZbGZ7bhTzL6jdEKLM3qyIoIyws1eANMMSju9/9V1Z2awasxUCFsbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739979598; c=relaxed/simple;
	bh=ucZpDd+h/0BrzfDrAYPhXrlYDhjDQwzQx+8935dd2Mo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sVdgrkLTNzkcMWT73KXy6oJ+AyKeuy5Ts7YSTHS8s4g6LdYW9IEVz8YCZYnvb6OwRduC5B7JSm1p8sPRjA+bpBakh8c6FwyyA4fxDq8MUqIzxUM3iUpVwxIeIe/of42D0/T7eigDXZUInE7/0VEBArU6CQKYjp7C59e4RH1NA8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQ+39GUp; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-471f16f4b73so30066781cf.1;
        Wed, 19 Feb 2025 07:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739979596; x=1740584396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aNyDehr5fYPZ7Ty7IjzjEdr8XsN1kQiCm3uBct3StSE=;
        b=KQ+39GUpL7b8qG5/lZ1osEAv6eT+F4cNfc5ethdUfoeoe5oqFuJ7O15RX8U9xKFYIA
         hdQChsBjMHkR4A1r5IUCd09xmqJQp0PADJeWnw1eQra4FqEFnZJqdnnIZCWUDNF8dP7U
         62fLwBPkcKd2R2hLngTlBZV1E9W3cMvuI+1zQt/QPazu1BUl4zYC33oStJAC5QwowGeH
         V8LSkq33A5XMHG+lkGtnnCkGzjqyyW32p34yJo9JtPV69CFwEuXQeagZykGOnfOv8uKk
         RUE8G0uwROnXXrK1oifauXLXV+qImTCxRKFpu2eYGY5fpY3T4/eMkmGu3WJkN4TMw0yu
         mA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739979596; x=1740584396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aNyDehr5fYPZ7Ty7IjzjEdr8XsN1kQiCm3uBct3StSE=;
        b=EfELrAftlYI29HQ3rxFpEMjiXJ+QjbzyNe7xyEMoa42ojaPBnR5SwzaPjF9F1DofbJ
         UIec8VMk9b+SWMwa/Ta3TWTAl8fuio+LKnMIjpRNNbTQVxFv2bipgZK42ouek1db6/qc
         sQTZ9j12FYwvVjwDadJFzaokP+w43cquwMMjiEfwEGFkPM66CUAvXjxrx8xXlpqhS5k0
         8KKlgLgs82k+WNvbrovncjX1VTpRGhyPsWrVg94mrbZZGhELlO3xbuEk6IImC4dJmiXC
         nJ68Ub9UsKApyANFgCOe8gg2KG5IKjXgWfVHeHgdA1h6moQacmXUqOmuqv2gKJ65uURT
         rzag==
X-Forwarded-Encrypted: i=1; AJvYcCUGWql1TLwUN76KakETUrsv4PvcIB2AkA6mA6yxVIPxCFFRd90NIrQHQMrbvYfuvlf+hcyKjWo6WkRn+XkV@vger.kernel.org, AJvYcCUTMRuVEo4Q/mB0OIyCJz5INU++JSSD4DLGAYPHxaD+axBh8ESCluVYP6yaG7recwoOLbXOJeX4tBZyA/r0TbrY@vger.kernel.org, AJvYcCVxFTrDi35nV2xz1DjJ1vmzqU3RDDcWj1i5XmsVxDsowdJDKYEyyoL+ZNIB/1NGlefiiuC2ApeJGVQ=@vger.kernel.org, AJvYcCX8Ja51RHTIgwcHbgNcNdJkLmoF0j4KQPpwXVLBU21ntpwK4o4z4x2EkoKLwXfqMYiLK4Ik7K9KGqPDS0YqvV3BEjoA@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg71I+M5eCR1qj8Gq+u66NECPV99Ztq7X8BP+vq6IbYX6IY/89
	+eakRxG7dl0mBpJlyodBqTWUwWVL46A3a+TmcXemLaC43vVVTwub
X-Gm-Gg: ASbGnctH5iMN+cwaDm6fzSHN61p0a0w3dQ3GJ9TGvW+X/rd1vBkOoh4ZhwYG5jyQ+kT
	BcuesD744BIGBxLmNpqmWtXK7t8EhgY7tFyG3K8yfOZQop7PxsXpgRIgAv4xkUsPBjL1XcGySzX
	g6q1mLV9NjWcpuHKM0/ur49tfR9YGrgJeGcXnhEuFx+fMEgJGtC8ptb2Y+w32RfjAc1+fpvmCY3
	3N+gZzCOFNYQ1O8MkWlOA7nih/q1xfIukki8EVz8C0XGlPMgzlt9B+6acNDSuEGNzRYJSC7diEV
	5/3Jz0ODLVKJX1P9PjBV454hgUdbblB+B3tf6cVBThqT6gChdpMyEygqrPEVl/GJTxeL1GfM8gG
	FSn5d6w==
X-Google-Smtp-Source: AGHT+IETAAN9vGlK/RY9wl5vH0WLgUlBki9V/4jDclpZL+w3WZFnPU1VP8c8MqdFIGGfDqb7vNq8gA==
X-Received: by 2002:a05:622a:1807:b0:472:7ce:2340 with SMTP id d75a77b69052e-4720824e081mr67377391cf.14.1739979596237;
        Wed, 19 Feb 2025 07:39:56 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47202260758sm18792281cf.15.2025.02.19.07.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 07:39:55 -0800 (PST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4553C1200043;
	Wed, 19 Feb 2025 10:39:55 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 19 Feb 2025 10:39:55 -0500
X-ME-Sender: <xms:S_u1Z5I3P3ZTB-cHrxGaE6FBCYCQi-L_rL25iX_jDKxGA3xJDcT0Ww>
    <xme:S_u1Z1LxZUMI6NyPDv8iTrbVS45QB4G4F7gVoNoCYr1Z3BF7y7aIKRFLfTSJZaN6I
    9pzyfBRkZmrtAE0Yg>
X-ME-Received: <xmr:S_u1ZxvEL9R4UxHfkEb2s7jiJrao0JII63fVgcOH1LiH9JG8dmkKxzRBsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgffhffevhffhvdfgjefgkedvlefgkeegveeu
    heelhfeivdegffejgfetuefgheeinecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvgdpnhgspghrtghpthhtohepvdelpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehrtghusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghorhgsvght
    sehlfihnrdhnvghtpdhrtghpthhtoheprhhoshhtvgguthesghhoohgumhhishdrohhrgh
    dprhgtphhtthhopehmhhhirhgrmhgrtheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    mhgrthhhihgvuhdruggvshhnohihvghrshesvghffhhitghiohhsrdgtohhmpdhrtghpth
    htohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhrvgguvghr
    ihgtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvggvrhgrjhdruhhprgguhhihrg
    ihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohgvlhesjhhovghlfhgvrhhnrghn
    uggvshdrohhrgh
X-ME-Proxy: <xmx:S_u1Z6YtTrqxl1QiNTSEGpqf-vJrX0PUJ1JgBoEwoRB9c5Jz78xf-w>
    <xmx:S_u1ZwZYmNV5r17GEREZK-9I51FV_rXF8VLAcy3U7r-O9Fmgwjg1rQ>
    <xmx:S_u1Z-B6YasqnO8A3xs6IWMEj9Sp1skjX4lJxskxIbaD5_OLKTiISw>
    <xmx:S_u1Z-YiBIbLAId_itzODocDF4qhjNMoB9dMZXaMFJttIOIDKENMcw>
    <xmx:S_u1Z8pM1m-UBBCaQR9LtpT4bdhRFz_lPeDFTFK_utruBl7VcOSHMDSL>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 10:39:54 -0500 (EST)
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
	linux-kselftest@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH rcu 08/11] rcutorture: Move RCU_TORTURE_TEST_{CHK_RDR_STATE,LOG_CPU} to bool
Date: Wed, 19 Feb 2025 07:39:35 -0800
Message-Id: <20250219153938.24966-9-boqun.feng@gmail.com>
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

The RCU_TORTURE_TEST_CHK_RDR_STATE and RCU_TORTURE_TEST_LOG_CPU Kconfig
options are pointlessly defined as tristate.  This commit therefore
converts them to bool.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202412241458.150d082b-lkp@intel.com
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/Kconfig.debug | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 25a9dc2be0dc..12e4c64ebae1 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -54,7 +54,7 @@ config RCU_TORTURE_TEST
 	  Say N if you are unsure.
 
 config RCU_TORTURE_TEST_CHK_RDR_STATE
-	tristate "Check rcutorture reader state"
+	bool "Check rcutorture reader state"
 	depends on RCU_TORTURE_TEST
 	default n
 	help
@@ -70,7 +70,7 @@ config RCU_TORTURE_TEST_CHK_RDR_STATE
 	  Say N if you are unsure.
 
 config RCU_TORTURE_TEST_LOG_CPU
-	tristate "Log CPU for rcutorture failures"
+	bool "Log CPU for rcutorture failures"
 	depends on RCU_TORTURE_TEST
 	default n
 	help
-- 
2.39.5 (Apple Git-154)


