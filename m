Return-Path: <linux-kselftest+bounces-17522-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07431971A8E
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 15:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4129287169
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 13:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72641B9B3C;
	Mon,  9 Sep 2024 13:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOUxbau4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A651B86DB;
	Mon,  9 Sep 2024 13:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725887704; cv=none; b=Z6kunkypyXDpy3nHGZr0+coDtw+EouraoCQWBccYbTPGLN2aLBsjl8s+AIm6Ny1RSAu9g09FCkl46bhVGJdCANlPZOm+kxSQXyPqx51Rh3G4pkRpvivyt7VZf7DdYwUzxDtYEGKR35Zh1vYcdSw5b6D5ZTwkonVoIP00fZTLXeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725887704; c=relaxed/simple;
	bh=y/3OrsBR+sZFAj8616m8r731dRe9LVv8lafCyokPSLU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=GVM6emBjqkB7eILgEqYjqAY7kh2PlZ60QRI81y77VLJez1juvuTqf4n6RVg6/tzeQRaA+ETm5plhX7u/3ELG36v1aUGr/3h9ruEcAPgmLnIwJWUOlESittxHPnubRxFCqk9akOFjmiVz70EMss1n5TVp/s85bv4vFoCRbmeO8xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOUxbau4; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e1a9f84699cso4355533276.3;
        Mon, 09 Sep 2024 06:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725887702; x=1726492502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlQng1wrkeBwblyfHEiZzBMwGt21TJFv/Am4SHC05BI=;
        b=QOUxbau4FhokHoo7kdeduKH8uvC8MSMWXvLdNEpE0bw7drgz8BeDof7+/UVEjqk2lQ
         QoPVEQXqZmFGLO+HRH9lTgqOoUWdhGMi0c5MYjmVbkWD3tZICAkVoWw4WrU/ITroT14s
         jLV9BshQtmDdWXb1NqP9Z6BO0orQf/GjKl4A/fTqSicmJoA0BNYR1NfG8LqkN0pXFeB+
         ZbIerMgw7bHyA7YqfuK6ovfN4LOkBv1oi0Mx19pbFSY1cAh26niO5ArrpSJwsTvH6Ow5
         sx0X694nqeXf9ScELea1Te/1mWtzi9GlWe0JQ6OibUjt1dT+kftmU0u73nsE3Bj2LXcS
         hTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725887702; x=1726492502;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BlQng1wrkeBwblyfHEiZzBMwGt21TJFv/Am4SHC05BI=;
        b=VElGECsM087K35mxhyDnvFzoAfb0jVe68IAuYFOyNUQkET/nbbmbcrXX+hMvIDE/uj
         yViYZ6aVWunCOj7SSfO1Yvz7ROb6aVQHA/3/0sEjfEJrtQUKVXEfHb6Fzms2vODkV4Hv
         khUlMu5sJp8ScWZvty6D0heeF6D1os//miapwe9iwFLI8+FhFZStv4GHAgXUCfdPl+5U
         7dL/Zb2QNzK5euoQ/Qj5CzSyGF8zNXLFJF4S4a5TtNoPLTTQ819ZVmo70F+iB2a7X2o/
         Df0O4oU84OwMaCYQVOM6O71eafJkykhjUBdVKI4qsTANHZs+hrMkzTv69Mr5m3MzD0jL
         mxnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh7rqZb9H8S+q3C/vqDKFogyBT1z119RPiPK3RmQj23XNnfOgbmOY5Yp10+v6xSujcqU0QtX62OVFwXlWmBGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrsgjPvVj8/MxDoH8zV9CVXjv+BHR5sKMFv0Lzq4j7N1LdNJ73
	UGFEoAeXq/byi0tgG08USN/v/tlrOFcmkWd3Sjfbm4mYOWYAR5B1
X-Google-Smtp-Source: AGHT+IFnWq9zThc8QTSn0i1bDJHX2WwbGI9LULn/plirEs9hJjhXIQzYXTwXNDaLDcwozqb25FYZtQ==
X-Received: by 2002:a05:6902:1145:b0:e11:7b7d:bd3a with SMTP id 3f1490d57ef6-e1d349efc64mr13097087276.36.1725887701857;
        Mon, 09 Sep 2024 06:15:01 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53474d8ccsm20675916d6.96.2024.09.09.06.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 06:15:01 -0700 (PDT)
Date: Mon, 09 Sep 2024 09:15:01 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
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
Message-ID: <66def4d595d4_320b62942a@willemb.c.googlers.com.notmuch>
In-Reply-To: <f5c79fd4-d317-4227-a3ca-05cf5e683cad@kernel.org>
References: <20240905231653.2427327-1-willemdebruijn.kernel@gmail.com>
 <20240905231653.2427327-3-willemdebruijn.kernel@gmail.com>
 <f63e7367-c4fb-4cdc-a44c-6accbc309c5a@kernel.org>
 <66db217a558c4_29a385294d3@willemb.c.googlers.com.notmuch>
 <ad780c53-9538-4d3f-a02f-1063828fc035@kernel.org>
 <66db9008e0b4e_2a33ef29428@willemb.c.googlers.com.notmuch>
 <20240906170456.5a113628@kernel.org>
 <f5c79fd4-d317-4227-a3ca-05cf5e683cad@kernel.org>
Subject: Re: [PATCH net-next v2 2/2] selftests/net: integrate packetdrill with
 ksft
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Matthieu Baerts wrote:
> Hi Jakub,
> 
> On 07/09/2024 02:04, Jakub Kicinski wrote:
> > On Fri, 06 Sep 2024 19:28:08 -0400 Willem de Bruijn wrote:
> >>>> No, we opted for this design exactly to use existing kselftest infra,
> >>>> rather than reimplementing that in our wrapper, as I did in the RFC.  
> >>>
> >>> OK, I understood from the discussions from the RFC that by using the
> >>> kselftest infra, the tests would be automatically executed in dedicated
> >>> netns, and it could also help running tests in parallel. That sounded
> >>> great to me, but that's not the case by default from what I see.  
> >>
> >> Perhaps that's something to change in the defaults for run_tests.
> >>
> >> Since the infra exist, that is preferable over reimplementing it for
> >> one particular subset of tests.
> >>
> >> Or if not all kselftests can run in netns (quite likely), this needs
> >> to be opt-in. Then a variable defined in the Makefile perhaps. To
> >> tell kselftest to enable the feature for this target.
> > 
> > Indeed, I was thinking along the same lines.
> 
> Yes, I was also thinking about a variable defined in the Makefile.
> 
> Because I suppose this variable will not be added in this cycle, and if
> a v3 is planned, would it be OK to simply prefix the 'packetdrill'
> commands with "unshare -n"? That would be similar to what is already
> done in Netfilter, and it prevents messing up with other tests/host
> settings?

Each target is built and booted separately, right?

These three initial tests share set_defaults.sh, so in practice this
should be fine. Most importantly, not affecting any tests outside
net/packetdrill.

But agreed that netns are needed before adding more.

The unshare approach sounds fine to me. Easier than to plumb a Makefile
variable through to the standalone run_kselftest.sh.

> >  3  give up on target proliferation; on a quick count we have 15 targets
> >     in ksft for various bits of networking, faaar more than anyone else
> >    + fewer targets limits the need for libraries, libraries local to
> >      the target are trivial to handle
> >    - ksft has no other form of "grouping" tests, if we collapse into 
> >      a small number of targets it will be hard to run a group of tests
> 
> It is good to have targets, to easily run a group of tests related to a
> modification that has just been done, and to limit the size of the
> required kernel config, etc. Probably easier to have different libs per
> target/subsystem, and when something can be re-used elsewhere, it can be
> extracted to a more generic lib maybe?

The conflicting CONFIGs between targets could be an issue. Even with
packetdrill I had to check HZ and saw a difference with net/bpf.

That said, there could probably be a way to select tests between
-c (collection/target) and -t (individual test) that uses a wildcard.

