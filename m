Return-Path: <linux-kselftest+bounces-17641-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E60B9740F3
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 19:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A315C1C253EB
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 17:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36467187325;
	Tue, 10 Sep 2024 17:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpWeyPnq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9328C192D7B;
	Tue, 10 Sep 2024 17:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725990345; cv=none; b=oJV/q9/4RNy6GpuTRAIh2dhcBsDL2azU93A3NK6wOaS6p3Be4Y//QngTNS+VGhU2LDV/VTgNwXRE3QJbGYojQvzjFnXDTrfKaTyz4CIijgNlwwskvXqF+b+YRaRQf9oqWuiqQQc62Ax0VMkyi3JosPHd8y/GlKHIGie1+ikuI14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725990345; c=relaxed/simple;
	bh=BaQmfcTG2lJzM8tPkszVtUXGqZq3pXZ33IMbrykza1I=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=jQ/5kT6ArrXJ8IXUa8V//wMzOxml+f9CyFoDrC2DIlbOPAzvfkRv7NCgl6TJ2X2JkW1F5RNTNgPCmp8gWK+OpSUXhZpU0d9azKnMN3N3kxeNUwBgV1PjGVcrRZrnYZaQwcUwZUcvN1HESpMJEkaQR2qZSQxwKJdejSnTVbpcHLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpWeyPnq; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-458311b338eso8952101cf.2;
        Tue, 10 Sep 2024 10:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725990342; x=1726595142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HREYmolOhA2J4e+dF73ETKnMpllm7KFCJacQv55R3s=;
        b=MpWeyPnqKSFXEV9PzrIXOzcGDr6MrW2KZwlZSKEjf3PsPjM6ZU5R3qdYJlAz+AfUQS
         jNKVhZHRMC9xWlc6lTriENpE9O5SRTCBamrSpN2MCdXudEP4hqfs4x+OwkSrBQZsoX+e
         OBiqa5Mn7S8TSugteC+hHNPqDSx86PFAtCQ1ewZCgf+WOnStPxkjpNDw6bAJiKqoVUEq
         WJRDcB2oR217EeyP3PvV918dCpBUMZPyvE5QmZqw9XlcSqUd4R1S7tNwPfsfHvOnQhpn
         pAMyC+FYa0Vbu/oTqTtL1xXn0LLa+UypTXwYjjiwSnjc9qmJWH3Cnt/b8BkNt1YUBS2x
         OhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725990342; x=1726595142;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4HREYmolOhA2J4e+dF73ETKnMpllm7KFCJacQv55R3s=;
        b=ZelJUUZJGzSkwCJ+LWfPEPB9Rd2v6byGQbRWIoCRXeF3Yb06iNYg83uhaA5uLyEOz7
         kuGQ1pseSO6xK6VyzpSFq9BFHaBcdO3KwauIZ3fUjQ8WdO2w5WUyv+mTTBvPeRyPNTT9
         aLdAcSiyrxUK1OK9xjFoQn+R83Er4Jb8lfA+9/dRRvPnGV8oozkbGuWkrOVEzakh2nUb
         wM90zDK7Vuh2xyXnYOfGtccGCdbpFgqVaxv3xye7gT9Vti090qy4qWo2Oc/URN5ohOrw
         ZrrziXnDbQLe4YC7mVei6OUKHa6wXQ+ofct9HlU48K+k6a+aTHSVHt91Dnt9ZxUy7iRv
         PhqA==
X-Forwarded-Encrypted: i=1; AJvYcCUevWabnZwyUhnJm89nw6I8uH96/dqOgUGotcB0i5rMf2klLY4WPLJWZw32CEa+jMQ8FAdJfkljFe7XOMX39mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTsumy0nBgZwuDkxtN8HR9Utu2kAo4ydEs7i+6yOv7KBA7lWcB
	fn2mavUE233b7wyjANTILNFbOkINjhYpfgpq6P9FywzZ9JNn15Iw
X-Google-Smtp-Source: AGHT+IEfxCOjfTvlnSIunBfeTNyzlG7GokKpjhu56ym1r8rTfGNnZAMU2ArkLdDfEdqaJsoCFeUWcw==
X-Received: by 2002:ac8:5ad4:0:b0:458:3b22:9c2e with SMTP id d75a77b69052e-4584e9446f8mr3634751cf.53.1725990342450;
        Tue, 10 Sep 2024 10:45:42 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822e63873sm31741291cf.7.2024.09.10.10.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 10:45:42 -0700 (PDT)
Date: Tue, 10 Sep 2024 13:45:41 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 ncardwell@google.com, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, 
 fw@strlen.de, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <66e085c5c2627_c43f1294df@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240909102156.28ac12ba@kernel.org>
References: <20240905231653.2427327-1-willemdebruijn.kernel@gmail.com>
 <20240909102156.28ac12ba@kernel.org>
Subject: Re: [PATCH net-next v2 0/2] selftests/net: add packetdrill
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Thu,  5 Sep 2024 19:15:50 -0400 Willem de Bruijn wrote:
> > Lay the groundwork to import into kselftests the over 150 packetdrill
> > TCP/IP conformance tests on github.com/google/packetdrill.
> > 
> > 1/2: add kselftest infra for TEST_PROGS that need an interpreter
> > 
> > 2/2: add the specific packetdrill tests
> > 
> > Both can go through net-next, I imagine. But let me know if the
> > core infra should go through linux-kselftest.
> 
> Okay, looks like the set has survived DaveM's weekend cleanup of
> patchwork :)  I'm planning to apply it in the afternoon (Pacific 
> time), please LMK if anyone has objections / needs more time to
> review. I'm expecting 'unshare -n' as a follow up.

Which literally just inserting uname -n into the two invocations,
right?

	+++ b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
	@@ -33,9 +33,9 @@ fi
	 ktap_print_header
	 ktap_set_plan 2

	-packetdrill ${ipv4_args[@]} $(basename $script) > /dev/null \
	+unshare -n packetdrill ${ipv4_args[@]} $(basename $script) > /dev/null \
		&& ktap_test_pass "ipv4" || ktap_test_fail "ipv4"
	-packetdrill ${ipv6_args[@]} $(basename $script) > /dev/null \
	+unshare -n packetdrill ${ipv6_args[@]} $(basename $script) > /dev/null \
		&& ktap_test_pass "ipv6" || ktap_test_fail "ipv6"

I can send that. And then also add some CONFIGs we discussed:

+++ b/tools/testing/selftests/net/packetdrill/config
@@ -1,5 +1,10 @@
 CONFIG_IPV6=y
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
+CONFIG_NET_NS=y
 CONFIG_NET_SCH_FIFO=y
 CONFIG_PROC_SYSCTL=y
+CONFIG_SYN_COOKIES=y
+CONFIG_TCP_CONG_CUBIC=y
 CONFIG_TCP_MD5SIG=y
 CONFIG_TUN=y

And in the same series another two packetdrill testsuites, around 20
tests, say.

