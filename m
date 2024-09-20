Return-Path: <linux-kselftest+bounces-18168-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A74EE97D5DB
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 14:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA8121C21907
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 12:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0235216EB4C;
	Fri, 20 Sep 2024 12:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMU34yql"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8A716A94F;
	Fri, 20 Sep 2024 12:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726836884; cv=none; b=BXxf7Ni1nrVhAvwGafSuQ3paYGPsCOapSIQX+1ioSnYalIsC1RG5bAMYCy4mW7Z2CCNalyXuQysJ3fmJsaLGzwqdB32on5SWWqeZg+NRKlUGEFL/ZC5zxQeM1R4UAwfXuQs6LejaA2isNHW/k54tyTsB7zELQAgX6k+nXRvCBF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726836884; c=relaxed/simple;
	bh=9/XbiXvNtfo9Ahhxyxq6laPOnKE8m8Kp8tFx/t2A8HU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IYZmgn1afhG0pIuOneISwQmeZIeCTWAKT5nAKrTxDvYmeVmxGwHpa8iyGfw42orAVymnktCDTlhMcRPugQZIeVYwVRo9+kXui4Z8otGBTuewGt0zHJqiSNOkz0D+peTjNNdiZzIV9nK7vIN0t1aDefoy5QJGmKDro0Eip0KnA+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMU34yql; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8d2b24b7a8so563676666b.1;
        Fri, 20 Sep 2024 05:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726836881; x=1727441681; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RpseacMxjUgxJQCQ0p8XO6h9OmRZt38JJp1qVkqe51w=;
        b=TMU34yql4hRf5Xae89m4gKygnh9tPT4rFGTWxIhra3qMQSfEbEovbATlU6ArvpigF8
         x1KuU/uXkYSdkEzV4Z0ILaFScNgyHHThtG030/9vZdioAf7qUK/LqjteE6gTvOvIzaVH
         EnZ0r1pB1R2By3IltUcwFBfkrDRe/9dqxocwQ5tbrZjWOIUFGknf8pkwrv5uO4SCtOxV
         rB3R7Dff+31wvOlpbVm1h6ciUgswjuP9B/HxXpfH8BZC4a8CRogtOpBHZMmxV4hAHAWf
         TTZG0uBm5lKtAzLvPJnYPquhKuhV+Cd1v2Na+8m42JoZKtOQ+czwafBI9kFzkR60hP5x
         gIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726836881; x=1727441681;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RpseacMxjUgxJQCQ0p8XO6h9OmRZt38JJp1qVkqe51w=;
        b=myEt3++IZ/CgaTzHk8lO+nSNkEsUGB0NKw+2XfZIgXFVMBae5sL2COmw9a+y1JvYvK
         dDB8BZ7lFX9bbvyrLiTSClWrgeJAENFgUrjPJnJRrw+iIg8Ts5D9GRBW0nC93nhiUQoW
         65g50RXRJwuLSmabqMhN9d1YyhyVP1NzZFUQNs7qDFqw/J2HNdwsnyxN4CIw4S38on08
         fjkYx5JWNe7K90GiSFe/SBPZIZi34aDXB9S9eU7t/5S8Gw13spIOPgwIlQWfUM6wecZR
         8MNbf5LyRiQEhyrpZ/3Y917buzeo10713NkWNuK+dyCI65CGqJB964tDk0bUNUxaSutg
         11NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvm43/Vt26Bnktef7BOUmjSSsLPlX6f5wNi0lCJ2ZvGng3ZbW1n3rjGM/es1DYWSeMVXSXBlo2UrYHujjilg23@vger.kernel.org, AJvYcCW+9bK2AUk0CdPmVzVJMzJFS8868WoaDtLZy26GNENHhOW+4v5xlMVaLNG+wCToBlasMkC0JCsE@vger.kernel.org, AJvYcCXlKIAqTCWVb2v+Nx0SQ520L2Cen+6wKvWnYsi35QFnYD8oAw4JTQKjeLdzJnFXmKSSmdGfxTOsKSsh9Ds=@vger.kernel.org
X-Gm-Message-State: AOJu0YweMQCVzISXeUD9hxfK7UVjVBARV16YEE3pyQaLo7XBLcgVT160
	xQu5LfEePpOfF/XlqAKg14kcqqqb2MtBF1CNRFfzZgI7VLoLngDe209EUE4M5Ds/grJGb3aLlYG
	Dk0IDx2xBGsNTzA2KnmIgah0GxJIetV7l+WngaQ==
X-Google-Smtp-Source: AGHT+IFNG7eWZ0hTCSU9dnVSqE4S90H/FnkxsBpn+k7zYe1p9qup8+dfLEzF2OhL+u23ShqmAAZopTPFI7IK4WbqJI8=
X-Received: by 2002:a17:907:94cf:b0:a77:c051:36a9 with SMTP id
 a640c23a62f3a-a90d35107d9mr296404166b.9.1726836881397; Fri, 20 Sep 2024
 05:54:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c92569919307749f879b9482b0f3e125b7d9d2e3.1726480066.git.jamie.bainbridge@gmail.com>
 <Zuw7d9eRGo4wdVP3@shredder.mtl.com>
In-Reply-To: <Zuw7d9eRGo4wdVP3@shredder.mtl.com>
From: Jamie Bainbridge <jamie.bainbridge@gmail.com>
Date: Fri, 20 Sep 2024 22:54:29 +1000
Message-ID: <CAAvyFNiAXb7wuDMi6tRVuzHUwkSwtCtJOzM7LGxk5nDEtaqgyQ@mail.gmail.com>
Subject: Re: [PATCH net v2] selftests: forwarding: Avoid false MDB
 delete/flush failures
To: Ido Schimmel <idosch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Sept 2024 at 00:56, Ido Schimmel <idosch@nvidia.com> wrote:
>
> Hi,
>
> Thanks for the patch and sorry for the late reply (was OOO).
>
> On Mon, Sep 16, 2024 at 07:49:05PM +1000, Jamie Bainbridge wrote:
> > Running this test on a small system produces different failures every
> > test checking deletions, and some flushes. From different test runs:
> >
> > TEST: Common host entries configuration tests (L2)                [FAIL]
> >   Failed to delete L2 host entry
> >
> > TEST: Common port group entries configuration tests (IPv4 (S, G)) [FAIL]
> >   IPv4 (S, G) entry with VLAN 10 not deleted when VLAN was not specified
> >
> > TEST: Common port group entries configuration tests (IPv6 (*, G)) [FAIL]
> >   IPv6 (*, G) entry with VLAN 10 not deleted when VLAN was not specified
> >
> > TEST: Flush tests                                                 [FAIL]
> >   Entry not flushed by specified VLAN ID
> >
> > TEST: Flush tests                                                 [FAIL]
> >   IPv6 host entry not flushed by "nopermanent" state
> >
> > Add a short sleep after deletion and flush to resolve this.
>
> The port group entry is removed from MDB entry's list synchronously, but
> the MDB entry itself is removed from the hash table asynchronously and
> the MDB get query will only return an error if an entry was not found
> there.
>
> IOW, I think that when you do get a response after deletion, the entry
> you get is empty.
>
> Can you please test the following patch [1] (w/o yours, obviously)?
>
> [1]
> diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
> index bc37e47ad829..1a52a0bca086 100644
> --- a/net/bridge/br_mdb.c
> +++ b/net/bridge/br_mdb.c
> @@ -1674,7 +1674,7 @@ int br_mdb_get(struct net_device *dev, struct nlattr *tb[], u32 portid, u32 seq,
>         spin_lock_bh(&br->multicast_lock);
>
>         mp = br_mdb_ip_get(br, &group);
> -       if (!mp) {
> +       if (!mp || (!mp->ports && !mp->host_joined)) {
>                 NL_SET_ERR_MSG_MOD(extack, "MDB entry not found");
>                 err = -ENOENT;
>                 goto unlock;

This works perfectly for me. Previously I would get at least 2
failures in 10. Without my patch and with the above patch, 100 tests
pass without any failure.

Many thanks for looking at this!

Jamie

