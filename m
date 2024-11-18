Return-Path: <linux-kselftest+bounces-22201-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C58A9D19D4
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 21:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D061AB20D12
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 20:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8C11E5711;
	Mon, 18 Nov 2024 20:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SwSMowbK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB8313E8AE
	for <linux-kselftest@vger.kernel.org>; Mon, 18 Nov 2024 20:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731962681; cv=none; b=LPFxSLiYD1JfrlBbwLf/JfKpT+ACRPBpiKrFtuY23eZpykcMihI464Z/dH9ogr5gTvjeHwJbj9yPSbFX1xZyR9q60CfbXKQW+iGfqPu3IEp1crAlSX8hWSRG6VdFvi8gUKNtCb6zaNyobea4lEo2Xh64a7Xb6ul1h1CFGbfPa0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731962681; c=relaxed/simple;
	bh=H0b+SpqbFoJPnwpm7c72ks/wxWmayaWT0c94/M3TaIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bToVNIFtxDZdwPJqIJrBWPDJSrrn+LQwfkZyn5Az+8SkffKqpynt8zyiaSJEyH1NLkbcGHANt4rxEe7TNyFXDUvvmh7XVL3wjk2+ghSPV5lgzYUgD6VXzVGSFubS0dZwWTUT/JH+5jDzuZ1r1anaCVidrsS9FElGirJ6BLh2c4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SwSMowbK; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-211f1a46f7fso36335ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Nov 2024 12:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731962679; x=1732567479; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aKTaVzXiCAec3Tyjrd89WA6CeVRBCOnqqKiIQ4/209w=;
        b=SwSMowbKwp08InbAaKc2V3vbQ/uf/IovkSYTl3w6xjRXRRpGqKi/H3sNa7AxhBDxCC
         E3yScrF5GEdfUckGWfrVQ4P9zuRwn9ZBhLHUj8bawkVqKkSHxPENRctEx9EEjBd3G7S5
         dxW6qzD2XFs/p/iVSu+SHy3R7b6p5bwimmon99iTBdhfKhD39sDZSafbvbKW108cBL4q
         mynoEJ0wJfm5XCdeIhjIMIzSAqj4E7xyOXeBbgQr/2W6//3K289w8HFSzYHOxK3MgFRQ
         ney+fubK17Iku4fygN5DLHzLyLJgLOtPbAZErVpjQ+IiUfXOrQJy3uRGkyF46RWDOdDj
         yK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731962679; x=1732567479;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aKTaVzXiCAec3Tyjrd89WA6CeVRBCOnqqKiIQ4/209w=;
        b=hU8XvxBLrpbVDh7HuapRTM6vWgLRXjXUXa8Kxc4P0vCchKP+NWA24BwDWdI7V1mSZI
         TNV737dUJdk22lHk7ojzMSGEL1Azs5ztm9Zb+bgOSPYwgPLLV3TF3XtMR50J41p6+XYv
         Gzl8ykW21GAzJi4S62gYI8AtKoQZHYPmkdNL8WOjTfPgppbBhM1nblnvaWAvetWAs49W
         AduZE0ybUcN/MGH4mZPpDB2G7huBy9LglnxpbrbQlfvFZMJ6mKhrWgMZ3r7sN9FsYxVj
         HJ0A5klQhAPNJ7TBri5ThX9ERFbtgNIyEBnbMWH4Ow6H3s0v3PAOuiwyotu1UNAGnqpx
         KJkg==
X-Forwarded-Encrypted: i=1; AJvYcCV8h8gcHoB99VhfcO6ReQaUZIYUEdaCL12jEZefZn+MWEHH8ZYu8vKvwtMEr5+PiFSnW5tQjVSfr60nP0htjPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFzT4dfNPJCEm7k6smJPAGl7wdHzB1DeFcmHe2wLkhden5f7ck
	Emx3dG5925gW3eDrV3RmqFMDwwM7/LcFbuxeWYkK7ZB5mEOpeQBelBsq35pr0LPjC6haJqaDrKZ
	YlGfXJuVn5BhpIGrjTfXuoh4moRjW23+3OJMW
X-Gm-Gg: ASbGncthoo/XOEN5rQxIvwjcVH1CP7DkITROHz2+8Fv7LIKpPzn/6oJ9GgUKO0mWnmR
	HeC3h4DY+AXEt4GsdhEWqx3n9AARUPa3l
X-Google-Smtp-Source: AGHT+IHGBmy57KAu0HlHubkKaTd1BqOfX8EYJnZETNfEPTp1FMAEayQici09tykpfSJn3YIPEIejT7GVORR65C3UiSg=
X-Received: by 2002:a17:902:f68f:b0:1fc:60f2:a089 with SMTP id
 d9443c01a7336-2124ea7e89cmr326155ad.17.1731962678568; Mon, 18 Nov 2024
 12:44:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905200551.4099064-1-jrife@google.com> <ZzpkPWrrb_Z2ZfCq@zx2c4.com>
In-Reply-To: <ZzpkPWrrb_Z2ZfCq@zx2c4.com>
From: Jordan Rife <jrife@google.com>
Date: Mon, 18 Nov 2024 13:44:26 -0700
Message-ID: <CADKFtnTThMBDKCXufNaeci5uCeddOgLvXmqszyJoT6N=6xtWug@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] wireguard: allowedips: Add
 WGALLOWEDIP_F_REMOVE_ME flag
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: wireguard@lists.zx2c4.com, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jason,

Thanks a lot for taking a look!

> I'm actually less enthusiastic about this part, but mainly because I
> haven't looked closely at what the convention for this is. I was
> wondering though - this adds WGALLOWEDIP_A_FLAGS, which didn't exist
> before. Shouldn't some upper layer return a relevant value in that case?
> And even within the existing flags, for WGPEER_A_FLAGS, for example, old
> kernels check to see if there are new flags, for this purpose, e.g.:
>
>         if (attrs[WGPEER_A_FLAGS])
>                 flags = nla_get_u32(attrs[WGPEER_A_FLAGS]);
>         ret = -EOPNOTSUPP;
>         if (flags & ~__WGPEER_F_ALL)
>                 goto out;
>
> So I think we might be able to avoid having to bump the version number.
> GENL is supposed to be extensible like this.

I think the challenge with WGALLOWEDIP_A_FLAGS in particular is that
because it didn't exist since the beginning like WGPEER_A_FLAGS, there
are kernels out there that have no knowledge of it and wouldn't have
this check in place. While I think it's a good idea to replicate this
check for WGALLOWEDIP_A_FLAGS as well for future compatibility, we
still need some way for clients to probe whether or not this feature
is supported in case they're running on an older kernel. If we want to
keep the version number as-is, I see a few alternatives:

1. Include WGALLOWEDIP_A_FLAGS in the response of WG_CMD_GET_DEVICE.
This would be a new field inside each entry of WGPEER_A_ALLOWEDIPS. If
the result of WG_CMD_GET_DEVICE contains WGALLOWEDIP_A_FLAGS then a
client knows that it can use features WGALLOWEDIP_F_REMOVE_ME. It
could potentially be used later to contain persistent flags for an IP,
but for now would just be zeroed out. This fails if there are no
allowed IPs configured for the device you're trying to configure, but
in the case where you're trying to use WGALLOWEDIP_F_REMOVE_ME you
probably would.
2. Keep everything the same. Don't bump the version number. Clients
could in theory try to use WGALLOWEDIP_A_FLAGS with WG_CMD_SET_DEVICE
then check if their request had the intended effect (e.g. checking if
the IP was removed).

I slightly prefer approach 1 myself, as I feel it's a bit cleaner, but
I'm happy to discuss some other approaches here. I'm trying to think
about how these probes could be used inside the WireGuard Go library
and wg itself. Assuming approach one,

* For libraries that manage WireGuard like
golang.zx2c4.com/wireguard/wgctrl the first time a client uses
.Device() (WG_CMD_GET_DEVICE under the hood) there would need to be
some logic that looks at WGPEER_A_ALLOWEDIPS for one of the peers and
sets some internal flag like c.supportsAllowedIPFlags. When a client
later calls c.ConfigureDevice() the library would disallow direct IP
removal if the feature is not supported (c.supportsAllowedIPFlags !=
nil && !*c.supportsAllowedIPFlags). Alternatively, you could do all
this up front while initializing the client by creating some dummy
device + peer, adding some IP, then using WG_CMD_GET_DEVICE to see if
WGALLOWEDIP_A_FLAGS is present in the result.
* Similarly for wg, if the user is trying to remove an allowed IP
you'd first query the allowed IP for a peer and check for
WGALLOWEDIP_A_FLAGS if it doesn't exist in the response then the
command would fail and print something like "not supported".

Bumping WG_GENL_VERSION is cleaner still, since clients in userspace
just need to check an integer value and avoid any probing logic.
However, like you I am unsure what the convention is here and whether
or not this has any unintended effects.

> This file doesn't really do the _ prefix thing anywhere. Can you call
> this something more descriptive, like "remove_node"?

Sure. I'll update this in v3.

> Reasoning for this is that it copies the logic in add()?

As for the cidr > bits check, the intent was simply to fail if the
user passes an invalid value for WGALLOWEDIP_A_CIDR_MASK. Although,
unlike the add() case, I suppose we could just remove this check.
Worst case if a user passes something high like 255 remove() would
just be a no-op. It looks safe to remove !peer check as well. I can
update this in v3.

> What's the reasoning behind returning success when it can't find the
> node? Because in that case it's already removed so the function is
> idempotent? And you checked that nothing really cares about the return
> value there anyway? Or is this a mistake and you meant to return
> something else? I can imagine good reasoning in either direction; I'd
> just like to learn that your choice is deliberate.

Yes, I opted for idempotence here intentionally. At least for the use
cases I have in mind the intent is basically "remove all these allowed
IPs from this peer if they exist". If an allowed IP already got
removed or is mapped to another peer somehow then that's fine. I'd
imagine it complicates the code in userspace to have to deal with
corner cases involving possible error codes returned when removing a
batch of allowed IPs. You'd need to query the device again, reform
your request, etc. I /think/ add() is idempotent as well in cases
where you re-add an IP to a peer, so there's some symmetry here.
Perhaps if there are use cases that need more stricter checks in the
future we could introduce a new flag to return an error code in this
case.

> As I mentioned above, you need to do the dance of:
>
>         ret = -EOPNOTSUPP;
>         if (flags & ~__WGALLOWEDIP_F_ALL)
>                 goto out;
>
> So that we can safely extend this later.

Good idea. I will add this in v3 as well.

> We get 100 chars now, so you can rewrite this as:
>
>                         ret = wg_allowedips_remove_v4(&peer->device->peer_allowedips,
>                                                       nla_data(attrs[WGALLOWEDIP_A_IPADDR]), cidr,
>                                                       peer, &peer->device->device_update_lock);

Nice, will do.

> That comma should be a semicolon because what comes after is a complete
> sentence, and there's no conjunction.

Good point. I think we might actually need a comma /after/ otherwise:
"...; otherwise, ...": "WGALLOWEDIP_F_REMOVE_ME if the specified IP
should be removed; otherwise, this IP will be added if it is not
already present".

> I'm not so keen on this, simply because we've been able to do everything
> else in that script and keeping with the "make sure the userspace
> tooling" paradigm. There are two options:
>
> 1. Rewrite netns.sh all in C, only depending on libnl or whatever (which
>    I would actually really *love* to see happen). This would change the
>    testing paradigm, but I'd be okay with that if it's done well and all
>    at once.
>
> 2. Add support for this new flag to wg(8) (which I think is necessary
>    anyway for this to land; kernel features and userspace support oughta
>    be posted at once).
>
>
> Thanks for the patch. I like the feature and I'm happy you posted this.

Option 1 seems like a heavy lift for this patch. I think option 2
makes more sense, as long as there is an understanding that netns.sh
needs to be run with the latest and greatest version of wg in order
for all tests to pass. Maybe we can add a version check to selectively
disable the remove IP tests if wg is on an older version. I agree
though that long term option 1 would be nice, as it provides a finer
level of control and tests could be run without as many external
dependencies. I can get rid of the remove-ip cruft and send two
patches to the wireguard mailing list if that works, one for the
kernel and one for wireguard-tools.

However, this raises some questions about the wg interface itself
which would be used both by netns.sh and end users. Looking at the
current interface for wg, the way to configure allowed IPs currently
is "wg set". For example,

wg set peer ABCD... allowed-ips 192.168.0.24/32,192.168.0.44/32,192.168.0.88/32

The intended effect is to completely replace the allowed IPs for that
peer rather than to make an incremental change. I think we'll need to
extend the interface a bit. There are a few directions we can take
here:

1. Add a new flag to "wg set" like --incremental in which case it
won't use WGPEER_F_REPLACE_ALLOWEDIPS under the hood. Support addition
or removal of allowed IPs with a "-" suffix on CIDRs you want to
remove (192.168.0.24/32-,192.168.0.44/32-,192.168.0.88/32).
2. Same as 1 but with a new argument name, allowed-ips-diff instead of
the --incremental flag. This appears more in line with the current
style of wg's arguments.

There are a lot more variations here, so I wanted to get your input
here before just picking a direction. Thanks again for the thorough
feedback!

-Jordan

