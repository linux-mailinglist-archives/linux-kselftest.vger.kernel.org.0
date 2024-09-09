Return-Path: <linux-kselftest+bounces-17527-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE20A971D7C
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 17:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F21B3B21D2C
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 15:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A19719478;
	Mon,  9 Sep 2024 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCsY2mCK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33111B947;
	Mon,  9 Sep 2024 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894422; cv=none; b=M0kYJDRhCeTT41bBmRSfQq1p+z/DWl3gNqrKO+yvsumA4feB4YiTczZ/m3Mb6RvSCVZPKyyRUlV/Z56SI+FEPa/vi5us8sXIvn1Nw0h9UDz87GkIE8cO875Mhu2qWYjudIbbBFG7E9X/A9oQvGYgCy7IyMb4FGnY54KwmYoaRjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894422; c=relaxed/simple;
	bh=8oY6ixYSwbaxM+K+ezpgZ0n4hBkTnlKhDNIT0sa7vFQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=PPsL6L4u5zqusRC3XnCj82+My6k03fhpsxW/L72uUqQxO0fHwVPuufL6imhKfzx+qZRFFmHB/cAFzQoaZ0KKeaAFbaTJGhM6a3jTrOHwtOQGsAsxW3362Gq+mRhpEiRRmVgnZjcs+zay7OvtNqzUq44AjpE6FoLBYdTxIxuiTAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCsY2mCK; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4581d2b0fbaso15613651cf.1;
        Mon, 09 Sep 2024 08:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725894419; x=1726499219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbtyjUXSMPQm8aWoQ0Y3Rd//y49YwNiBLRybzgfy2Kk=;
        b=gCsY2mCKdf+TtxS2OGCnehUWr/00G47eqivZpnii36qZJgjxiZs9ARC4s/XfufK8PN
         ZgikKLHDBkt7Fd55l/V/531G4hv/OWFfJryCGaeCXCuOwTjGa/XFlSW1P0xhSLwnzdKw
         J01EMJ8gucuKx8CkSebHxM8ornQNOr8WBiTzOvJ4psWTtm4skL3KxsYLw/DmmqP/FjdN
         J+DGcJEeorrsAZtp25nhZsfC26t87PHVc07JNQID0sABLw78sEkswBUDgC8GRCGn9Hgw
         R6apiAh1vORL4LKIwr1ZJbxu7tgvHbIGJfiQZ5uZD9yCiLPW7K2vD7DBVIJGXrU+/O21
         ycCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725894419; x=1726499219;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UbtyjUXSMPQm8aWoQ0Y3Rd//y49YwNiBLRybzgfy2Kk=;
        b=Y1P7YquVzD54aPKrGk+wLgclwTbgG9rs2SL38qfifJa+kop5zH1tfPGlhNxmWcnZig
         8I4EP5gSjawrwTmHcjcJDIlZt8yJu6CXng7nmBw5lnBqmjl9BVmg2fPIYQfs30zyvWSS
         VrKwR2TxXxVmQcV8KrNCloICgSlUvc9uBH2L1vLyKi9dettdp/SSdARlhzXKzuu/oQJQ
         4f8H4o78Uk9OreeCj8id+urBF/DFzafm2rACCFkCpp9z2tDFrYj4rKjQS40q2nPN6QHT
         IEvYBvkOqAICuQCMcPO4DgkgX7FlTU+YK0qlM8IZ9X1s7qjdo8qZfshqNMAq6UkJ0se/
         GOIA==
X-Forwarded-Encrypted: i=1; AJvYcCUukmtgX7+i7rA4dLQU10Ek9B/6bb4sQ7ePc9yjnKcRvTsft1rhDwLl6/KbD5UISSUwhYdF7ykruH+lUwI=@vger.kernel.org, AJvYcCVGIUgEkqCFvgdlJthSgVEuF8vaJ0eJC19OC0S1XHphlpffjfiePVI50U2uoun7XjOlgQLN43M3kDEst6iYanTp@vger.kernel.org, AJvYcCWmsp/JpL0Bpr1nbIl4xfbtB+Vwzd7TxKc0A0KwVlepYPt734C6xy8icpNNqdRW4cqV1Lct44GF@vger.kernel.org
X-Gm-Message-State: AOJu0YyoWlvCnyrhFNpdLPkQptQJmW7+BkZRSzGozDUoRRjPeUobS0lg
	0YehpmdlPR1hVgM4j2Vhv4GL00aEEnPlRbiGJdqEXxz0roXGF/ob
X-Google-Smtp-Source: AGHT+IGIOKZBpF/t8zuJjPazB04VxSLqZlSqfSwrTs+j/xCWxknmp2/Gaf7tisMrkm+pM8HtT41OxA==
X-Received: by 2002:a05:6214:2c0e:b0:6b2:de80:2be5 with SMTP id 6a1803df08f44-6c528502427mr105420896d6.31.1725894419298;
        Mon, 09 Sep 2024 08:06:59 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53434764fsm21520146d6.74.2024.09.09.08.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 08:06:58 -0700 (PDT)
Date: Mon, 09 Sep 2024 11:06:58 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Sean Anderson <sean.anderson@linux.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>, 
 linux-kernel@vger.kernel.org, 
 Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org
Message-ID: <66df0f1276f03_38749294ac@willemb.c.googlers.com.notmuch>
In-Reply-To: <9d5bf385-2ef0-435d-b6f9-1de55533653b@linux.dev>
References: <20240906210743.627413-1-sean.anderson@linux.dev>
 <66dbb4fcbf560_2af86229423@willemb.c.googlers.com.notmuch>
 <9d5bf385-2ef0-435d-b6f9-1de55533653b@linux.dev>
Subject: Re: [PATCH net] selftests: net: csum: Fix checksums for packets with
 non-zero padding
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Sean Anderson wrote:
> On 9/6/24 22:05, Willem de Bruijn wrote:
> > Sean Anderson wrote:
> >> Padding is not included in UDP and TCP checksums. Therefore, reduce the
> >> length of the checksummed data to include only the data in the IP
> >> payload. This fixes spurious reported checksum failures like
> >> 
> >> rx: pkt: sport=33000 len=26 csum=0xc850 verify=0xf9fe
> >> pkt: bad csum
> > 
> > Are you using this test as receiver for other input?
> > 
> > The packet builder in the test doesn't generate these, does it?
> 
> It's added by the MAC before transmission.
> 
> This is permitted by the standard, but in this case it actually appears
> to be due to the MAC using 32-bit reads for the data and not masking off
> the end. Not sure whether this is a bug in the driver/device, since
> technically we may leak up to 3 bytes of memory.
> 
> That said, it would be a nice enhancement to generate packets with
> non-zero padding as well, since they are an interesting edge case.

Thanks for that context.
 
> > Just trying to understand if this is a bug fix or a new use for
> > csum.c as receiver.
> 
> Bug fix.
> 
> >> Technically it is possible for there to be trailing bytes after the UDP
> >> data but before the Ethernet padding (e.g. if sizeof(ip) + sizeof(udp) +
> >> udp.len < ip.len). However, we don't generate such packets.
> > 
> > More likely is that L3 and L4 length fields agree, as both are
> > generated at the sender, but that some trailer is attached in the
> > network. Such as a timestamp trailer.
> 
> Yes, as noted above we don't generate packets with differing L3 and L4
> lengths.
> 
> >> Fixes: 91a7de85600d ("selftests/net: add csum offload test")
> >> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> >> ---
> >> Found while testing for this very bug in hardware checksum offloads.
> >> 
> >>  tools/testing/selftests/net/lib/csum.c | 16 ++++++++++++++--
> >>  1 file changed, 14 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/tools/testing/selftests/net/lib/csum.c b/tools/testing/selftests/net/lib/csum.c
> >> index b9f3fc3c3426..e0a34e5e8dd5 100644
> >> --- a/tools/testing/selftests/net/lib/csum.c
> >> +++ b/tools/testing/selftests/net/lib/csum.c
> >> @@ -654,10 +654,16 @@ static int recv_verify_packet_ipv4(void *nh, int len)
> >>  {
> >>  	struct iphdr *iph = nh;
> >>  	uint16_t proto = cfg_encap ? IPPROTO_UDP : cfg_proto;
> >> +	uint16_t ip_len;
> >>  
> >>  	if (len < sizeof(*iph) || iph->protocol != proto)
> >>  		return -1;
> >>  
> >> +	ip_len = ntohs(iph->tot_len);
> >> +	if (ip_len > len || ip_len < sizeof(*iph))
> >> +		return -1;
> >> +
> >> +	len = ip_len;
> >>  	iph_addr_p = &iph->saddr;
> >>  	if (proto == IPPROTO_TCP)
> >>  		return recv_verify_packet_tcp(iph + 1, len - sizeof(*iph));
> >> @@ -669,16 +675,22 @@ static int recv_verify_packet_ipv6(void *nh, int len)
> >>  {
> >>  	struct ipv6hdr *ip6h = nh;
> >>  	uint16_t proto = cfg_encap ? IPPROTO_UDP : cfg_proto;
> >> +	uint16_t ip_len;
> > 
> > nit: payload_len, as it never includes sizeof ipv6hdr
> 
> OK
> 
> --Sean
> 
> >>  	if (len < sizeof(*ip6h) || ip6h->nexthdr != proto)
> >>  		return -1;
> >>  
> >> +	ip_len = ntohs(ip6h->payload_len);
> >> +	if (ip_len > len - sizeof(*ip6h))
> >> +		return -1;
> >> +
> >> +	len = ip_len;
> >>  	iph_addr_p = &ip6h->saddr;
> >>  
> >>  	if (proto == IPPROTO_TCP)
> >> -		return recv_verify_packet_tcp(ip6h + 1, len - sizeof(*ip6h));
> >> +		return recv_verify_packet_tcp(ip6h + 1, len);
> >>  	else
> >> -		return recv_verify_packet_udp(ip6h + 1, len - sizeof(*ip6h));
> >> +		return recv_verify_packet_udp(ip6h + 1, len);
> >>  }
> >>  
> >>  /* return whether auxdata includes TP_STATUS_CSUM_VALID */
> >> -- 
> >> 2.35.1.1320.gc452695387.dirty
> >> 
> > 
> > 



