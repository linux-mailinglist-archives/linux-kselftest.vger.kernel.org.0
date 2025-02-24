Return-Path: <linux-kselftest+bounces-27314-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FB8A4137E
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 03:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6A891736D8
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 02:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D199424168B;
	Mon, 24 Feb 2025 02:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STa3TsHG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EA724060C;
	Mon, 24 Feb 2025 02:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740363766; cv=none; b=phjiAzXHsgPj000u6mr8q3s1CjfiDH1Xr0j7lMSeWxv6DXL8wgt/80u+YFYFbqfNmnpWIROR53HUBYKu4C5kWyefMXTMkForlPxJ626V1IGdD4gby8CtumKPKmkLyZf/CJ8lqbgRY0PEuWu0BeSBtM8P90GeswE7POFQpelKL+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740363766; c=relaxed/simple;
	bh=mRU9WCM67lJH5/lbA8uOg4PhTTj8coyG+QePvNGba3k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Iz/E8RKGavcLcA9O+Tx5r4lsEOFirbxFZmOgUYLXRKMR1k06Mcp6sm6eYHQGFXcR2qCgwKMY6W2Rowd3Dv7MJmOsNn9rxqsfNfLnqftBd4adeZz0gRSxbmsbyLZp6Vm+D4C0d5qKozQZQbyZKrhlATiqtIQJujnsxFefckjcxEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STa3TsHG; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e67fad4671so35417956d6.1;
        Sun, 23 Feb 2025 18:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740363764; x=1740968564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eg6dUqpGoKhiV+cpu434M/fIW4z0zJ0cT+ywlwyprkA=;
        b=STa3TsHGJtVb+MCCGHC2sB6gvb5cnWXjN892Yue9Jq0rRDfO5B6LsCbQ2O79PP9llf
         XeTe8iY5qTueKaqUtCQE5XGkjFFfKhPDs/4PunaCEH1+Bp/LErEY4bHQQOliqEPSqQP8
         X8TZFKEdARr1Qi4gKXTgwRlYmAYmBZ/S6dmH6BN3Cw078SJlG+FUpqgq9hWfpduqrttg
         EP5W0RQTZxykJYB4YcLuZHspxiDwMhdzrO0QHvEYdwS6Dj1yQ0ZQBvArBzsCtgoxJods
         W1l0n6yClTMmUnfa4pkqWmff8WbCH97dqilf/0WkgpHsmsiZlP3U4pZ6BshT92sGpkCb
         2mnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740363764; x=1740968564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eg6dUqpGoKhiV+cpu434M/fIW4z0zJ0cT+ywlwyprkA=;
        b=P6JgmEPlTWPEEpPo61yT7mEKnV8sPqV7feH29rRluMgJSFnaCr/FW8fsS2hVKwIw4w
         T3+IpupwRxUIIexn1V+NxK6/lkCDbLk58qtQnhfZVSshjOYnrxUoAup8iAVo14ZhI7Bu
         ZR6gKEf5cAY4rsUlpJb7rIzu+SttnaHOkQ0dvA1dI0g65+3FJ2tH+aCIHHEt2pWFmRFi
         XYQEv8bcBMCfeKWmTpn9MZ3bsDOawsVdMTpb86c2LmN8MspWbMRWRx7qHH28dvWuvnjZ
         9HPnGZLRum5HXWftmpvMheIBWsGdpwyoHfS6XtIA3JX4TbCCEEmFFJ5r8vcDJwfxsmAt
         iD0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBf4aFLi3TAcMMCcglyC2x1blEYzEHWVe0SArJYvy62s1jPsTqQcnoxDYb1ZMqATOOm5gA9iaWKvwi0E8U@vger.kernel.org, AJvYcCWK0UD0UnHItb49ZFez36bm5Z5Uhrpk55u8X9LBwHHilUXa/tpvGjJtDxzFskJFC3NN2cGDlxI6Bkohswqbv7WD@vger.kernel.org, AJvYcCWiq2n5Sx/nQ/TRi4fa/Ml6MdUxFhy2S+KZj83ONKN22VAEgR28RdNGAV24/2sO7dl/cUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/E8f16js9tvlpk7F1RfRwiUgDUhaZi5TPhXHVxvs6DXFppBqx
	lpygdtc5iLfbU8r9zxUQk5ScEOUec1ibWfbQ3K7j/KTI8e4RQPNW
X-Gm-Gg: ASbGncvD+ML09oDBiJ19x7uzYqt8Cpkw+Bq68wifSP2hZX7UZVvxdd9cGIpubPITmBX
	6h9JVTIKXy4GYy16cXKinaspR4Xd2Uv2PzkHHz5blubKCO/J3ITfKy2AcIiIa34isgzon/SJVjC
	i3mDowyISWjku8OChMGVpCtlaBXUs83+S8/6ZpJu+2iaN5uxaTH8ODoX39sx1BKRGCfSpImXIY3
	yB0VhDYL3riOQ/NMfkysRR/8Jb95IPBsgYc2hK161wxzr8/9SXiAWxPBT4K7COA/Eavd/FQECZJ
	JaGyPjggmPMnIRvCq8bAEXXjHnNnjjorKj/AUhhMzc4htyU2qnTK3lhWWcDcOewhHMRPnbljK+O
	aFCptKovjORYMkGv+
X-Google-Smtp-Source: AGHT+IGzIhpbr9iU21ineA2QNZuQdz9ARj2vtfEGBqgEatKHIidqLPnjQqCQPKzUU874OlLqnK72cg==
X-Received: by 2002:ad4:5fcd:0:b0:6e4:4011:9df7 with SMTP id 6a1803df08f44-6e6ae7f876emr161379806d6.16.1740363764052;
        Sun, 23 Feb 2025 18:22:44 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e6b1759af6sm36879046d6.93.2025.02.23.18.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 18:22:43 -0800 (PST)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 404341200066;
	Sun, 23 Feb 2025 21:22:43 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Sun, 23 Feb 2025 21:22:43 -0500
X-ME-Sender: <xms:89e7Z0TkqinST9SRXFayvL1sJ04hwrka4EyPGqi-8QMqUQxYkAS6XQ>
    <xme:89e7ZxxlfvWusXbhdPKFUghPzMJsV49wnxxA_ByumabheIA_7RGu-iMY5T3H0uqLN
    aWJGzzNJD6ZoH37VQ>
X-ME-Received: <xmr:89e7Zx2N2IreMK79T6HFvGdLC5g-YtOAjWTp6NZeU2TP0D6MsQWEP_XFSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejjeehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfev
    ffeiueejhfeuiefggeeuheeggefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
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
X-ME-Proxy: <xmx:89e7Z4CPmy7L_gbR0pXhasWDSiyD3pYqRcBGB57_7oJS9QyLY6SfXA>
    <xmx:89e7Z9jdbCErGK1W_8N7wfGxNUvgaLPoztPh35cQ4Atim75RWiH-4A>
    <xmx:89e7Z0ohsV6uQU12PwkocX_bnGzLMlL-FSB-r4PHpgnUOvPKfIK04g>
    <xmx:89e7Zwg6KcTUhNM7OGqnajD-ZKQTPoBbQjQTHi-vA0mcKZpBdPT_aw>
    <xmx:89e7Z0SywQfDK0WE-370QknMc_6t89kJMC4hoxgj73JSm70BuUg-QaEL>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Feb 2025 21:22:42 -0500 (EST)
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
Subject: [PATCH rcu 18/20] srcu: Document that srcu_{read_lock,down_read}() can share srcu_struct
Date: Sun, 23 Feb 2025 18:22:12 -0800
Message-Id: <20250224022214.12037-19-boqun.feng@gmail.com>
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

This commit adds a sentence to the srcu_down_read() function's kernel-doc
header noting that it is permissible to use srcu_down_read() and
srcu_read_lock() on the same srcu_struct, even concurrently.

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
index a0df80baaccf..317eab82a5f0 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -359,7 +359,8 @@ srcu_read_lock_notrace(struct srcu_struct *ssp) __acquires(ssp)
  * srcu_down_read() nor srcu_up_read() may be invoked from an NMI handler.
  *
  * Calls to srcu_down_read() may be nested, similar to the manner in
- * which calls to down_read() may be nested.
+ * which calls to down_read() may be nested.  The same srcu_struct may be
+ * used concurrently by srcu_down_read() and srcu_read_lock().
  */
 static inline int srcu_down_read(struct srcu_struct *ssp) __acquires(ssp)
 {
-- 
2.39.5 (Apple Git-154)


