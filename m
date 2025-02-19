Return-Path: <linux-kselftest+bounces-26992-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A70AA3C3E3
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 16:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2971E189C7F6
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 15:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066A51FF1CA;
	Wed, 19 Feb 2025 15:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pb6BVlWv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5761FECAF;
	Wed, 19 Feb 2025 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739979593; cv=none; b=AVAU/RqMkH2ZdZsX+ZifdUkPWK3RHJg4UgLhrdllEL5TsH4o7QtRkVVOf9ao6LzHtpltj98y9hT0pH+0TuVcZYfza3bLKoNcB7/8M6wcH46kP/4yqqlK94W9fhlCmvdwVs28aH36CsIEXQ0w7PTsKns/NZ2JsUHMJCofSR+nJMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739979593; c=relaxed/simple;
	bh=tMCs17sY5bbPnvle/eomw45/1sQVLJD085rrA9fStgU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bQsqYS8RQwzPhAFZjFykfOeG7X7a0AWzIz5tAY8VtMjVwn64n9vZUKY1ENecGdCpvw8zXihGbhy9oUS0ju/944+s2qo5l7hVs0cvG5QA9K9S9yJRhtqfWcALyd1oyoXA2r0qpkjzeZDnU21USOIpRFLtDynwMNa1DIrgyCNLIS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pb6BVlWv; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-471f88518c8so16752191cf.0;
        Wed, 19 Feb 2025 07:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739979591; x=1740584391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sC5BbHzn6YW2uGJuRqqxqybW7SYKYinnzIpochKMS8c=;
        b=Pb6BVlWvP2adWBwEgrR5jGA0rrl47SuEV7cxxntBm4HRB3YZFaMmBNs+GfyhDgECo3
         QeqmK+Z8p0eYBQSOM3O80DkKF+lQLvsDi1DZrv5Srf4ru+AF+uWdVvtEKMzGNaUcS9kj
         /w3LyD3q6sXVWBm2kzKuZczLS29znTwhbjTldhRIMeiqKv8VuuYTDSW1JyjkSDdMViwe
         sEfkt6Gq1dsZYJ1o6HC/NW6cf6Vw1t3YRnb8kxH05kqhE1Km6gU1a8vr21vSkCc1X1tR
         06mzO8PQhR/GFJiLhMEfOvr3yQe2wdRXm2QRHz+gaSafMWYMbC5nji+jIjJRCJMrCkcX
         Hvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739979591; x=1740584391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sC5BbHzn6YW2uGJuRqqxqybW7SYKYinnzIpochKMS8c=;
        b=tq90tID6Iev1IoeqVa/s2sexpBiK/8Zi9JJ5mqiuc/to3I0cxpZuzByfzM4aiGa0fs
         OsOhWr6A9TpQd0FJG/ZCwHL6R9B6d+PZZyj+76VVAysH53B99HuUUXGSADFBgD7ThQ+M
         C5J1du+DZJFlzS0AMn867uqQAhhQf569hcJyI+ELmqCSMYUxJPYKiukNmzy9zo7kuHux
         biaYFqZ/5lGxeuL7u4WzQIgsC3Ll3T8Cb3Zf1C8C/ZtTOy2ga06O7VgFvsJrQwSntJhe
         EPHpKe6rmpuB/xztQAxe9WXXHrv+wENdGAqi2wMOIruUcI2zKfToVAHpopOLBiTMJXEP
         0Pnw==
X-Forwarded-Encrypted: i=1; AJvYcCUJLUL5YsME7uy2XQ6EA4t1Ztsw0+wYU8/yS/mDfPcu4+kIS40M7MadbJrqCfggsXezWbKpsy07R0k=@vger.kernel.org, AJvYcCVLhkZMtD1y7CPpAQ2k1ro0Mt0VbELpWDFQ2NjwAK93TAD+jpQt5uAHALXl/x5tqBPHQuHSPuDGbi1Kv1hL@vger.kernel.org, AJvYcCVhGGiKR+ZEyY2w1SAywrF4HraVnYlzTPM220Jb7ECMe8WU/2XR0MQwIBiC6vqsgkZwXRxkMh9807URrmm0ZtAc2ovj@vger.kernel.org, AJvYcCWeQv3q9DlUq+yGQEQqLAdIKU3N/hSqHQYEI52Gtfj1uns2addGtKUb1l/PdADh6taHyg2sWOucMsFXfVYBru69@vger.kernel.org
X-Gm-Message-State: AOJu0YwjuT8hk6/6pzXOvYA52FNKhHP6uNjmV5SUiI9K42BVjg1x1QT0
	cHTAha2esYLbTTsd088UGsb/V486bK0A77ePMSZGq+CV+a1SMHYv
X-Gm-Gg: ASbGnctW2kLf+6WZ93fwATkFt1z0yjEgnMgawQjexrXmFxrZ4ryef0B6lRiRp5qGApO
	LDJX2iBFY5rNiJcES/eWSHQDq1AYihtbqF19fh7D0igt9hS5F6tzbIIHG+HlkBRcFJWqkYnNcsv
	wW/WQ/G8+83yvdYmVwTf19lK1tbhwWQzNObYcisEAWBNiKKTzYi6VJbeFVH5ISESWTVwMB/r4Hl
	KrOFqEnFKBZNd8o2vG0tVzzrkHpVk75M47KKfyGvr1B/KBdpuTf+mno6caAMnp07trrWGkAK0gw
	WdsP6V5HW9WhWxA9gHVN0+rU3kzmbJmAAnibGcwPCLZeGLAPos1QtibPrSDcvyDNNy9KAkVPY/O
	Icz58fg==
X-Google-Smtp-Source: AGHT+IHOQ8rJgLbOtCxMBXY2CRBZH+xkRfbgJC65UZTMCbSoyhPA8Qt2GrxJ23iijSbZM9KbEk1Eaw==
X-Received: by 2002:a05:6214:4002:b0:6d4:254f:1c8e with SMTP id 6a1803df08f44-6e6975bd097mr65389446d6.37.1739979591229;
        Wed, 19 Feb 2025 07:39:51 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471f69cc6b7sm28952231cf.46.2025.02.19.07.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 07:39:50 -0800 (PST)
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfauth.phl.internal (Postfix) with ESMTP id 248551200043;
	Wed, 19 Feb 2025 10:39:50 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-13.internal (MEProxy); Wed, 19 Feb 2025 10:39:50 -0500
X-ME-Sender: <xms:Rvu1Z-FYvKt2B-cdGkWb0rr4294sauRuvYQ4x9j22qLpALbPUTP-rA>
    <xme:Rvu1Z_UZbqxfY8w2lgQXgXC4dPm9fEAxHJhvG3VMhFw6S1Cd7SyhuH4q8kK0kAzgL
    ntRK9x8SijK0_-wyw>
X-ME-Received: <xmr:Rvu1Z4KDb7FUtp6abKFJqJf12Q1PQr0QWB4t-8wptVIv2esi-mnSvNbw9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeeifecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:Rvu1Z4E2XflfzYFHkfcOmeyF5kAqqArRdcurvvzNUu_FdtDrtDS1KA>
    <xmx:Rvu1Z0Xf10TBHK_KOpqwMAtGD49yxp5-fk0tdKFPK2R4R8uHtp1ICA>
    <xmx:Rvu1Z7OqBG0LOJZrvEa2nL95IFehxfAcBLjLGoNvi8IR9Q97UqfzLw>
    <xmx:Rvu1Z70R-6XcVe0vcziwT9cJBRR-JBOMZb3RXAxloGFe6taiNNh8Ww>
    <xmx:Rvu1Z1Uow4ZUp2S2d_wYNPVYWVXzUaapmHXlXkkPV9UBhOcUdTO8GWAZ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 10:39:49 -0500 (EST)
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
Subject: [PATCH rcu 05/11] rcu: Trace expedited grace-period numbers in hexadecimal
Date: Wed, 19 Feb 2025 07:39:32 -0800
Message-Id: <20250219153938.24966-6-boqun.feng@gmail.com>
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

This commit reformats the expedited grace-period numbers into hexadecimal
for easier decoding and comparison.  The normal grace-period numbers
remain in decimal for the time being.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/trace/events/rcu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index e81431deaa50..63fd8aa99af7 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -207,7 +207,7 @@ TRACE_EVENT_RCU(rcu_exp_grace_period,
 		__entry->gpevent = gpevent;
 	),
 
-	TP_printk("%s %ld %s",
+	TP_printk("%s %#lx %s",
 		  __entry->rcuname, __entry->gpseq, __entry->gpevent)
 );
 
-- 
2.39.5 (Apple Git-154)


