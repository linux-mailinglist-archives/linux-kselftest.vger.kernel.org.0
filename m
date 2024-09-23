Return-Path: <linux-kselftest+bounces-18241-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD02497EF6E
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 18:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CDFD28260C
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 16:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0F719F133;
	Mon, 23 Sep 2024 16:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="daVkDwpz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C5B19F10A
	for <linux-kselftest@vger.kernel.org>; Mon, 23 Sep 2024 16:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727109852; cv=none; b=bMOIicNxYMJGcGVmSzDOIo+rWoNWn+zwBuYh0VF6ebmrhaK59c22I7O2uboKS+Gk9F7xxpzhL0/xA8Keiv+9SjcE0HH4MqB+DdDjAiV9x36fRQN3uY0kfYm4o/v8suXj056SKFNRMmWf+fjQHfxH3oeh+4iSxcr2XGnqebujTZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727109852; c=relaxed/simple;
	bh=Tj+rFNp3RUciTXesDUXO/T3ijZS2swiWrnOzdR/3ZKU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mXtL41IDecqRbzE0NsKg70XofzWm5gCMLxcrVDl7APcdzyzrPGh6udx2JtVwibwzvSs4U0NPyzXLfYQ5A3Arp6UTGsPCFPK83AVcmOgjCWwb+w5XhYgohOogLNpb3g5xT3Plf1aJVZlXId6okEhujWJ5ZL1tKHOGLc+y0avuvTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=daVkDwpz; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f763e9e759so52164011fa.3
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Sep 2024 09:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1727109847; x=1727714647; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7hXi1VEpOam7nRQRtm5F/Kvp+UglOEaCxtSWG+fjmik=;
        b=daVkDwpz3QLTSVUSRzhDXYYUc5IEyvk6XBEYW7MYoZwdhLTkqWo8QPxcFtwiPGIy91
         Rr0j/I4FLTBXO8QG8hCbXZcqmYPkeT6qEvdILvrpVxEZgBSiY2cm9DRpLYkqBc58Y8oy
         HHUf9Q2TK7ZklJTsNGUSmFd+eWwA26QOqLQi1dI/91w2m4wDgCD4YGHCU5Lpu16xDAAM
         OMQjW92SBPYk+xhRGbgA1MQyziE6hv3WH6aYf2PL2FQYDtE9q1JpxjXuH4mtfdARYpy0
         saJK5FqzgLwprT7p5yC4rOS4GSb4QcvQ8rmBeuZdTebImEpAeSMKA86+k+OnNwCjZ5ZJ
         kUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727109847; x=1727714647;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hXi1VEpOam7nRQRtm5F/Kvp+UglOEaCxtSWG+fjmik=;
        b=EuGj56TDASkYq6eT9A1V/DgVO5Cy9AYGsTqQOFgskkqA2VXaGsmGckGAB13TeMLp/H
         7zunMsoG0epS0F6oUW1gVXUXgVh+TH2j+sKvy4Wi78V8Qo96Rzcgsy4+nmmcCMPhHmSO
         nS2NlTMWkdsF8DtvZrcXInjXD4lnc/ardsrdUg3nHlwlCzL8QnepVC6MzcVAgwvf3LRw
         R8BZadHn+WbiVzO4e76CjXO5VCmFWMlhXywAaW0us/Bzln6yd0MB4kDsHUYBFcj7THwm
         ieYLJdzvaBaofaB2wGmDBX0fjZFTSsuZuiau/5HUfJOs8JVCGTE5kWtLW0Z38+/1dY0p
         iJhA==
X-Forwarded-Encrypted: i=1; AJvYcCV3PcYWYPikViu1JSv2uXJBs6UkOguFlzF5GQLGb23xptf/LkKLZCmgWR/UohynzeGfTAUaiRCGW58oj+8mIxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVItvqRWaldkoXZ+n7Z3EIVUsqRxv0ZsT4keysZZeNRlptefyJ
	jiscxvLd7snrNYC90XLoiUDHOWloV/UQWD5qAW5IXmKIRGcutEYEScZNdiA2SJM=
X-Google-Smtp-Source: AGHT+IGlbMKRBwW56/ddt0TnX1I2vjFVhxMgqZqw8MiUMLPOYvNyOV111a+PrQFKMaiXrHW/JzfNmQ==
X-Received: by 2002:a05:651c:547:b0:2ef:2344:deec with SMTP id 38308e7fff4ca-2f7cb385ddfmr56631961fa.45.1727109847473;
        Mon, 23 Sep 2024 09:44:07 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:5a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb535eesm10506299a12.29.2024.09.23.09.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 09:44:06 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: David Laight <David.Laight@ACULAB.COM>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,  'Tiago Lam'
 <tiagolam@cloudflare.com>,  Eric Dumazet <edumazet@google.com>,  Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>,  "David S. Miller"
 <davem@davemloft.net>,  David Ahern <dsahern@kernel.org>,  Jakub Kicinski
 <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  "Alexei Starovoitov"
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  "Andrii
 Nakryiko" <andrii@kernel.org>,  Eduard Zingerman <eddyz87@gmail.com>,
  Song Liu <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,
  John Fastabend <john.fastabend@gmail.com>,  KP Singh
 <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao Luo
 <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Mykola Lysenko
 <mykolal@fb.com>,  Shuah Khan <shuah@kernel.org>,
  "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
  "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
  "kernel-team@cloudflare.com" <kernel-team@cloudflare.com>
Subject: Re: [RFC PATCH v2 2/3] ipv6: Support setting src port in sendmsg().
In-Reply-To: <29fea23839cf489488f9228a44e79d21@AcuMS.aculab.com> (David
	Laight's message of "Mon, 23 Sep 2024 15:45:27 +0000")
References: <20240920-reverse-sk-lookup-v2-0-916a48c47d56@cloudflare.com>
	<20240920-reverse-sk-lookup-v2-2-916a48c47d56@cloudflare.com>
	<855fc71343a149479c7da96438bf9e32@AcuMS.aculab.com>
	<87r09a771t.fsf@cloudflare.com>
	<29fea23839cf489488f9228a44e79d21@AcuMS.aculab.com>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Mon, 23 Sep 2024 18:44:04 +0200
Message-ID: <87msjy7223.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 23, 2024 at 03:45 PM GMT, David Laight wrote:
> From: Jakub Sitnicki
>> Sent: 23 September 2024 15:56
>> 
>> On Mon, Sep 23, 2024 at 01:08 PM GMT, David Laight wrote:
>> > From: Tiago Lam <tiagolam@cloudflare.com>
>> 
>> [...]
>> 
>> >> To limit its usage, a reverse socket lookup is performed to check if the
>> >> configured egress source address and/or port have any ingress sk_lookup
>> >> match. If it does, traffic is allowed to proceed, otherwise it falls
>> >> back to the regular egress path.
>> >
>> > Is that really useful/necessary?
>> 
>> We've been asking ourselves the same question during Plumbers with
>> Martin.
>> 
>> Unprivileges processes can already source UDP traffic from (almost) any
>> IP & port by binding a socket to the desired source port and passing
>> IP_PKTINFO. So perhaps having a reverse socket lookup is an overkill.
>
> Traditionally you'd need to bind to the source port on any local IP
> (or the wildcard IP) that didn't have another socket bound to that port.

Right. Linux IP_PKTINFO extension relaxes this requirement. You can bind
to some local IP (whichever is free, plently to choose from in 127/8
local subnet), and specify the source address to use OOB at sendmsg()
time (as long as the address is local to the host, otherwise you need
additional capabilities).

> Modern Linux might have more restrictions and SO_REUSADDR muddies things.
>
> And I don't think you can do a connect() on an unbound UDP socket to
> set the source port at the same time as the destination IP+port.
> (That would actually be useful.)

You can. It's somewhat recent (v6.3+) [1]:

https://manpages.debian.org/unstable/manpages/ip.7.en.html#IP_LOCAL_PORT_RANGE

It's not on par with TCP when it comes to local port sharing because we
hash UDP sockets only by 2-tuple. Though, some effort to improve that is
taking place I see.

The recipe is:

1. delay the auto-bind until connect() time with IP_BIND_ADDRESS_NO_PORT
   socket option, and
2. tell the udp stack to consider only a single local port during the
   free port search with IP_LOCAL_PORT_RANGE option.

That amounts to something like (in pseudocode):

  s = socket(AF_INET, SOCK_DGRAM)
  s.setsockopt(SOL_IP, IP_BIND_ADDRESS_NO_PORT, 1)
  s.setsockopt(SOL_IP, IP_LOCAL_PORT_RANGE, 44_444 << 16 | 44_444)
  s.bind(("192.0.2.42", 0))
  s.connect(("1.1.1.1", 53))

You can combine it with SO_REUSEADDR to share the local address between
sockets, but you have to ensure manually that you don't run into
conflicts between sockets (two sockets using the same 4-tuple). That's
something we're hoping to improve in the future.

> OTOH if you just want to send a UDP message you can just use another
> system on the same network.
> You might need to spoof the source mac - but that isn't hard (although
> it might confuse any ethernet switches).
>
>> We should probably respect net.ipv4.ip_local_reserved_ports and
>> net.ipv4.ip_unprivileged_port_start system settings, though, or check
>> for relevant caps.
>
> True.
>
>> Open question if it is acceptable to disregard exclusive UDP port
>> ownership by sockets binding to a wildcard address without SO_REUSEADDR?
>
> We've often suffered from the opposite - a program binds to the wildcard
> IP and everything works until something else binds to the same port and
> a specific local IP.

Let me see if I understand - what would happen today for UDP is:

app #1 - bind(("0.0.0.0", 53)) -> OK
app #2 - bind(("192.0.2.1", 53)) -> EADDRINUSE

... unless both are setting SO_REUSEADDR (or SO_REUSEPORT and run under
same UID).

That is why if we allow selecting the source port at sendmsg() time, we
would be relaxing the existing UDP port ownership guarantees for
wildcard binds.

Perhaps this merits a sysctl, so the admin can decide if it is an
acceptable trade-off in their environment.

> I'm sure this is grief some on both TCP and UDP - especially since you
> often need to set SO_REUSADDR to stop other things breaking.
>
> 	David
>  
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

