Return-Path: <linux-kselftest+bounces-47481-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE480CB7EB2
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 06:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4ECE303AEB7
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 05:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4713730DEDE;
	Fri, 12 Dec 2025 05:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="MWCugvxG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f97.google.com (mail-ed1-f97.google.com [209.85.208.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07AA248176
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 05:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765516627; cv=none; b=HTBwRlbX+bPTMQYHEYvpoSOBeF378zIzsGg5zY6vFNPnVgmqX5ibN1HjrQygZSp6rc8ylzhBBQwDhw/Yr1XMeOXypYaeCGEh9+8JQ91EN78hWsfHcg6bRYApxWrAlJplsnqv//G8mWjraEXxCmL43YpgqSwTEja5kw+0vm8RcMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765516627; c=relaxed/simple;
	bh=Nv/iP0PPlu7PYFQwI+jBPI8ffRylYj1zxIf1qEKb0tE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U16vTc6npp2Gk1/Cwu3OAmEjoltrhpxxzsMeAddjQRhQyoBkEIYHgxlYZqgdEUpIGDhS+WBA29ekUnhJaXj9Bmm3b4PZtLtkhCzczOZhy9Ea1yUzSii14mZgS8GnxMy/3Cqd5NWaLepM7fAIQLEVJv1AVJx3jTUbVHNro7Zl+P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=MWCugvxG; arc=none smtp.client-ip=209.85.208.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f97.google.com with SMTP id 4fb4d7f45d1cf-6416133c627so128154a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 21:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765516624; x=1766121424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ro8OsZF3uJAug4OtKve3tUbRbgxB29DrKAw1agkxt6A=;
        b=MWCugvxGJ5bcaQvBBCe1EmAUmVNkByLHzjxtweQxeEFnrCecaqahJ9CiRCBIIkuydN
         MxQHmXwdCOjCuq+uJxdAAtmiPpFWVKJoVYfz3vNCopWvy/E1rEn3UI2F44zdkRQUey3J
         nZ9YcqhYf5OGls7PC0umB4f9+5BpUb2+HYSUdUdLoZZvMmM47qkm5bq+1Z+uprJKrJfi
         1WQHbrNS0cEqie8Sr7+T4xAPt/Roa6MpZdMDM5NlvpNO7fJkMR5LhUmeGkkAHeuTqJ0X
         jJkAtUum3tKjyG0jD6S8rcBAWZtMMLUjtopMRrYF89udxUR1cHf1bNxNLwvOGy0bFBRm
         3t8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765516624; x=1766121424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ro8OsZF3uJAug4OtKve3tUbRbgxB29DrKAw1agkxt6A=;
        b=L9kyUIGVG6FNRJmXZYW2HZ3QstHf2Gx7+UI1rTfh8++F+J4mQ57qdGcWcahcRHz2Sw
         /w3jvJ1CK0Lydv2/ToV+XwtKaij1kCnKaKWffhfZftOi0iSVNrKslVa5cqbIwA3/lkQh
         S1z/yFZZWfjiOboZ4ZUelf1+qVEUhAHCzhdx4V0GUN1jnlGAWNKHr0Dp2MM4H8A3bshd
         pniNaOHJdmL9BALGntxeVrbIoN/+vC6E/4/+I0NoLijCHvcEf68uXIm1lkBWajS+KG3c
         xMy1EeWR5SubX7g4SLcTlH80Mi8f8ajUGm24gACbI2npgrvlsLcD/Icf0TLE4uWRQ5Lb
         vuKg==
X-Forwarded-Encrypted: i=1; AJvYcCUn40tvAMKwnQaJ+sFMdbAL6NlDwl5ELRXSwGfbUhLDM9v7aWLypkC2dzH1yt+iIjlPmHfYXvQk/rfpxlwKsG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH6QSkRbFrQYLYX9RsnFmkbKOI55OLko1qvWl5abKh+3rvzBp7
	wUfgTQBpbEJnpblRPlr0fXIHc9kR3oyma6DdUE+iJPFNNp+1R02hSfCNrgrf3OVs0IJkE9YjW8i
	Ip8IeavU54wUygK68nYhm6NRnmOussptko35u
X-Gm-Gg: AY/fxX5GYPA4P9Cnt9hHGqFB3uWwkd4u8HB7Mn1kYEDHL4Vt1j5uUszQ6mk8tXrXQOA
	w45yuYSsgqoBlUzZMWaVYxW6i+v3GIfobdnflsqNYwvpW45xEnHQaovOQmm6qlfRQoiyAUoC+du
	DlBkjDW+J+/idLGul20dGoZjpI6jd3L420E9sWXAcJ1sbQf2NPasCsqFasRxNCTGi3VrHAS7JmY
	J3FE65xgWBCbL/glQrDYCs6fblqERnI7jAe6QFP3ExQqnjyhrxzvfwJI2tJiPAnuJxdaCdzzbqy
	mZwBJo9R9YCPUZ/suIxn49gmZE+SqzWcZExKhO7Q6S8KPVWXvrRW9H4ZPyhdfNywP8TKhM3Y+8+
	gTodGmb3PBQ0DEtx5oK0bz3OLGlsBybtcStO44Z9Xpw==
X-Google-Smtp-Source: AGHT+IEawf1to/V+/+Qx4OvUJswtkr88PbpqURl0CG0xqAJjTju6BHqC8DK8KJbweq/Q9sRitTwQT4JGUkml
X-Received: by 2002:a17:907:60d0:b0:b76:c498:d410 with SMTP id a640c23a62f3a-b7d23aa5780mr34437166b.8.1765516623927;
        Thu, 11 Dec 2025 21:17:03 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id a640c23a62f3a-b7cfa609a26sm86779066b.86.2025.12.11.21.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 21:17:03 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 9E989340B96;
	Thu, 11 Dec 2025 22:17:02 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 9B464E41A2E; Thu, 11 Dec 2025 22:17:02 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 1/8] selftests: ublk: correct last_rw map type in seq_io.bt
Date: Thu, 11 Dec 2025 22:16:51 -0700
Message-ID: <20251212051658.1618543-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251212051658.1618543-1-csander@purestorage.com>
References: <20251212051658.1618543-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The last_rw map is initialized with a value of 0 but later assigned the
value args.sector + args.nr_sector, which has type sector_t = u64.
bpftrace complains about the type mismatch between int64 and uint64:
trace/seq_io.bt:18:3-59: ERROR: Type mismatch for @last_rw: trying to assign value of type 'uint64' when map already contains a value of type 'int64'
        @last_rw[$dev, str($2)] = (args.sector + args.nr_sector);

Cast the initial value to uint64 so bpftrace will load the program.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/trace/seq_io.bt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/trace/seq_io.bt b/tools/testing/selftests/ublk/trace/seq_io.bt
index 272ac54c9d5f..507a3ca05abf 100644
--- a/tools/testing/selftests/ublk/trace/seq_io.bt
+++ b/tools/testing/selftests/ublk/trace/seq_io.bt
@@ -2,11 +2,11 @@
 	$1: 	dev_t
 	$2: 	RWBS
 	$3:     strlen($2)
 */
 BEGIN {
-	@last_rw[$1, str($2)] = 0;
+	@last_rw[$1, str($2)] = (uint64)0;
 }
 tracepoint:block:block_rq_complete
 {
 	$dev = $1;
 	if ((int64)args.dev == $1 && !strncmp(args.rwbs, str($2), $3)) {
-- 
2.45.2


