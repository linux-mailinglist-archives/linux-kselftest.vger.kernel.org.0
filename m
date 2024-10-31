Return-Path: <linux-kselftest+bounces-21257-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 681F59B8394
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 20:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEC06B21843
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 19:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DE11CB51C;
	Thu, 31 Oct 2024 19:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijzJTorJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E85D8C0B;
	Thu, 31 Oct 2024 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730403682; cv=none; b=BKhEvE1h7uQpuvo7kPlxvX2unwxefND2sPuQLSb4b5kCz/nP2i+gkK/FP3Eh7dMJhbH4fnbH2GNGSjCya3ay4od+05jNys8/w+SjgoeQKt3EvH7ArqXca1NjS9YTGnYPsXlJIM+WbqUKrewkkl9umWaL80UjJdrkBoEvVmv+qms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730403682; c=relaxed/simple;
	bh=mQpBzHx3kkfxzGMnym5nCTlvuJ8e3aP2uHAEU5wBVuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NT5GiM2+BbI13lRR9pLHE0WEPaZ0SLXqtBkJdIePupAQsoo7xKOxgXhLlpyc6mntO2HF8mSjxTtOU8OHvg/JMhbvdcSpd4P1tMCYOGygY8nOaZ4LE/YkmRJWUabMFcfqMYY9HK1Zl45A8VWMBOJLqysr1QBR0JkON5i5OrCugAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijzJTorJ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e70c32cd7so1009029b3a.1;
        Thu, 31 Oct 2024 12:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730403679; x=1731008479; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WmTh0lK1tV85mOJEOm77C21iLMSxdhjULSj6XnN34w8=;
        b=ijzJTorJe6a3gzSbN8w/DC4boQ9hdW7RZH7LYKQ2jtrgJv8Dj196JwjpjYkV4FFk3L
         ae3kUHPJGGfhRGXyNe5K4JHVoo1vWphsRj2FHifyz/lijZSgj/89NYDK7PVvBiVJmtYh
         eGl3YM4EltggXyeAnECbq7snZBwH0fUIn32PDPzrd/T931UEiSKu20O6yc1udWU2iJnB
         p69GSYRVZZYDZzVr7ccZGoyNJVPs7EyUqIm1xEprR5sunNdYrlRHFFSH1z613eFZKB6H
         yM0R2deKqxLzPKo6o9vnv5TvJWRosDuUHc/vesDzT8Az2zt/mBdLsImNOcpAPMm3fpWK
         P6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730403679; x=1731008479;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WmTh0lK1tV85mOJEOm77C21iLMSxdhjULSj6XnN34w8=;
        b=FtdjPxZP9LOuHE1p4sMIxldhvnM9a5HEWDXnLMNKr2PKsYxHX9tJFbwcz0LquRz2oR
         H4YBTQtxuSkc7HFrEdbDD8phPA6V8uwL5G3E5hDh30M+ABelq4b8wE24HmUhDBbi2H+d
         UHVz2NIWQYNUfOJWTZCxvsVJdSxbxI5pSYAi7TYijbmhKlJyNaLutpYPpY6yOtuGX8oD
         mFhq0gDHmhTaMJpDnTyNaOc622BQqKPB/AOOfAaVOXbZ6cGz5GwcHLJW8ZfGL3xYFUAR
         Ov4f3eqwSgW+i2mdrcuzsXUDzK334ACKFPCiWlVsIy041skft2g+FmoRMfzlUniFv1tl
         TzAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9xqi9vBAMSNDnhcCooNP1uPxElmzzG9AHCCcASEf0282We+dUHkzlKavr6UaZqZ1r/GldPKi6iTGyd81gGKAF@vger.kernel.org, AJvYcCVxzE77tmCOhOUeBn2bCiMW+B4QNL/8RX0BCmPNuIObVV+blZDoM9ocdK0R5Hlrqml2Z8UC+gmkNC0EAq4=@vger.kernel.org, AJvYcCWj3arMjLjOjcfWHRRnRBmLZ2Ltg2nlV3KFc7csPp7E753zk//TkLpcjT4dfsdKXS8GaUt+cwDg@vger.kernel.org
X-Gm-Message-State: AOJu0YxyAOL3Of1OJkGlLWA2fagdJ9jLk/Uf6H/URcV4vmWovmU+AO/z
	QKpsEfXqUnho/P+pGBlXzOFHk59M6amI+Vql8oZdjkNCg9Rb2Xg=
X-Google-Smtp-Source: AGHT+IGvC+0ehyO75KlYs556ua8nKfNQdZDUUK0pru4i7nD2Mgv1rp4xJIZfL96F/RxkzLMFdlPUtw==
X-Received: by 2002:a05:6a20:d8b:b0:1cf:3d14:6921 with SMTP id adf61e73a8af0-1d9a84d168emr27866397637.35.1730403679384;
        Thu, 31 Oct 2024 12:41:19 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2e9316sm1526834b3a.148.2024.10.31.12.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 12:41:18 -0700 (PDT)
Date: Thu, 31 Oct 2024 12:41:18 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, willemb@google.com,
	petrm@nvidia.com
Subject: Re: [PATCH net-next v6 00/12] selftests: ncdevmem: Add ncdevmem to
 ksft
Message-ID: <ZyPdXr1hJ4OtWwf3@mini-arch>
References: <20241030142722.2901744-1-sdf@fomichev.me>
 <CAHS8izOBp4yXBg-nOSouD+A7gOGs9MPmdFc9_hB8=Ni0QdeZHg@mail.gmail.com>
 <ZyJM_dVs1_ys3bFX@mini-arch>
 <CAHS8izN6-5RJgKX08sgntYDVgETkBGpgoYToq8ezcy+tYHdaSA@mail.gmail.com>
 <ZyJSpBrhz7UJ0r7c@mini-arch>
 <CAHS8izPCFVd=opRiGMYu3u0neOP7yCJDX8Ff+TdURq2U-Pi27A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izPCFVd=opRiGMYu3u0neOP7yCJDX8Ff+TdURq2U-Pi27A@mail.gmail.com>

On 10/31, Mina Almasry wrote:
> On Wed, Oct 30, 2024 at 8:37 AM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > On 10/30, Mina Almasry wrote:
> > > On Wed, Oct 30, 2024 at 8:13 AM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> > > >
> > > > On 10/30, Mina Almasry wrote:
> > > > > On Wed, Oct 30, 2024 at 7:27 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
> > > > > >
> > > > > > The goal of the series is to simplify and make it possible to use
> > > > > > ncdevmem in an automated way from the ksft python wrapper.
> > > > > >
> > > > > > ncdevmem is slowly mutated into a state where it uses stdout
> > > > > > to print the payload and the python wrapper is added to
> > > > > > make sure the arrived payload matches the expected one.
> > > > > >
> > > > > > v6:
> > > > > > - fix compilation issue in 'Unify error handling' patch (Jakub)
> > > > > >
> > > > >
> > > > > Since I saw a compilation failures on a couple of iterations I
> > > > > cherry-picked this locally and tested compilation. I'm seeing this:
> > > >
> > > > Are you cherry picking the whole series or just this patch? It looks
> > > > too broken.
> > > >
> > > > > sudo CFLAGS="-static" make -C ./tools/testing/selftests/drivers/net/hw
> > > > > TARGETS=ncdevmem 2>&1
> > > > > make: Entering directory
> > > > > '/usr/local/google/home/almasrymina/cos-kernel/tools/testing/selftests/drivers/net/hw'
> > > > >   CC       ncdevmem
> > > > > In file included from ncdevmem.c:63:
> > > > > /usr/local/google/home/almasrymina/cos-kernel/tools/testing/selftests/../../../tools/net/ynl/generated/ethtool-user.h:23:43:
> > > > > warning: ‘enum ethtool_header_flags’ declared inside parameter list
> > > > > will not be visible outside of this definition or declaration
> > > > >    23 | const char *ethtool_header_flags_str(enum ethtool_header_flags value);
> > > > >       |                                           ^~~~~~~~~~~~~~~~~~~~
> > > > > /usr/local/google/home/almasrymina/cos-kernel/tools/testing/selftests/../../../tools/net/ynl/generated/ethtool-user.h:25:41:
> > > > > warning: ‘enum ethtool_module_fw_flash_status’ declared inside
> > > > > parameter list will not be visible outside of this definition or
> > > > > declaration
> > > > >    25 | ethtool_module_fw_flash_status_str(enum
> > > > > ethtool_module_fw_flash_status value);
> > > > >       |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > /usr/local/google/home/almasrymina/cos-kernel/tools/testing/selftests/../../../tools/net/ynl/generated/ethtool-user.h:6766:45:
> > > > > error: field ‘status’ has incomplete type
> > > > >  6766 |         enum ethtool_module_fw_flash_status status;
> > > > >       |                                             ^~~~~~
> > > >
> > > > This has been fixed via '#include <linux/ethtool_netlink.h>'
> > > >
> > > > > ncdevmem.c: In function ‘do_server’:
> > > > > ncdevmem.c:517:37: error: storage size of ‘token’ isn’t known
> > > > >   517 |                 struct dmabuf_token token;
> > > >
> > > > And this, and the rest, don't make sense at all?
> > > >
> > > > I'll double check on my side.
> > >
> > > Oh, whoops, I forgot to headers_install first. This works for me:
> > >
> > > ➜  cos-kernel git:(tcpdevmem-fixes-1) ✗ sudo make headers_install &&
> > > sudo CFLAGS="-static" make -C ./tools/testing/selftests/drivers/net/hw
> > > TARGETS=ncdevmem 2>&1
> > >   INSTALL ./usr/include
> > > make: Entering directory
> > > '/usr/local/google/home/almasrymina/cos-kernel/tools/testing/selftests/drivers/net/hw'
> > > make: Nothing to be done for 'all'.
> > > make: Leaving directory
> > > '/usr/local/google/home/almasrymina/cos-kernel/tools/testing/selftests/drivers/net/hw'
> > > ➜  cos-kernel git:(tcpdevmem-fixes-1) ✗ find . -iname ncdevmem
> > > ./tools/testing/selftests/drivers/net/hw/ncdevmem
> > >
> > > Sorry for the noise :D
> >
> > Whew, thanks and no worries!
> 
> Sorry, 2 issues testing this series:

Thank you for testing!


> 1. ipv4 addresses seem broken, or maybe i'm using them wrong.
> 
> Client command:
> yes $(echo -e \\x01\\x02\\x03\\x04\\x05\\x06) | tr \\n \\0 | head -c
> 1G | nc 192.168.1.4 5224 -p 5224
> 
> Server command and logs:
> mina-1 /home/almasrymina # ./ncdevmem -s 192.168.1.4 -c 192.168.1.5 -l
> -p 5224 -v 7 -f eth1
> here: ynl.c:887:ynl_req_trampoline
> using queues 15..16
> Running: sudo ethtool -K eth1 ntuple off >&2
> Running: sudo ethtool -K eth1 ntuple on >&2
> Running: sudo ethtool -n eth1 | grep 'Filter:' | awk '{print $2}' |
> xargs -n1 ethtool -N eth1 delete >&2
> ethtool: bad command line argument(s)
> For more information run ethtool -h
> here: ynl.c:887:ynl_req_trampoline
> TCP header split: on
> Running: sudo ethtool -X eth1 equal 15 >&2
> Running: sudo ethtool -N eth1 flow-type tcp6 src-ip 192.168.1.5 dst-ip
> 192.168.1.4 src-port 5224 dst-port 5224 queue 15 >&2
> Invalid src-ip value[192.168.1.5]
> ethtool: bad command line argument(s)
> For more information run ethtool -h
> ./ncdevmem: Failed to configure flow steering
> 
> The ethtool command to configure flow steering is not working for me.
> It thinks it's in v6 mode, when the ip address is a v4 address.
> (notice `-s 192.168.1.4 -c 192.168.1.5`). flow-type should be tcp in
> this case.
> 
> Reverting patch 9e2da4faeccf ("Revert "selftests: ncdevmem: Switch to
> AF_INET6"") resolves this issue. Leading to the second issue:

For IPv4, you have to use IPv4-mapped-IPv6, so your invocation needs to be:

./ncdevmem -s ::ffff:192.168.1.4 -c ::ffff:192.168.1.5 ...

Can you try that? I actually never tested that with non-ffff-prefixed
addresses, maybe that needs some error handling or something. Will
double-check on my side.


> 2. Validation is now broken:
> 
> Client command:
> yes $(echo -e \\x01\\x02\\x03\\x04\\x05\\x06) | tr \\n \\0 | head -c
> 1G | nc 192.168.1.4 5224 -p 5224
> 
> Server command and logs: mina-1 /home/almasrymina # ./ncdevmem -s
> 192.168.1.4 -c 192.168.1.5 -l -p 5224 -v 7 -f eth1
> here: ynl.c:887:ynl_req_trampoline
> using queues 15..16
> Running: sudo ethtool -K eth1 ntuple off >&2
> Running: sudo ethtool -K eth1 ntuple on >&2
> Running: sudo ethtool -n eth1 | grep 'Filter:' | awk '{print $2}' |
> xargs -n1 ethtool -N eth1 delete >&2
> ethtool: bad command line argument(s)
> For more information run ethtool -h
> here: ynl.c:887:ynl_req_trampoline
> TCP header split: on
> Running: sudo ethtool -X eth1 equal 15 >&2
> Running: sudo ethtool -N eth1 flow-type tcp4 src-ip 192.168.1.5 dst-ip
> 192.168.1.4 src-port 5224 dst-port 5224 queue 15 >&2
> Added rule with ID 19999
> here: ynl.c:887:ynl_req_trampoline
> got dmabuf id=1
> binding to address 192.168.1.4:5224
> Waiting or connection on 192.168.1.4:5224
> Got connection from 192.168.1.5:5224
> recvmsg ret=8192
> received frag_page=15997, in_page_offset=0, frag_offset=65523712,
> frag_size=4096, token=1, total_received=4096, dmabuf_id=1
> Failed validation: expected=1, actual=0, index=0
> Failed validation: expected=2, actual=0, index=1
> Failed validation: expected=3, actual=0, index=2
> Failed validation: expected=4, actual=0, index=3
> Failed validation: expected=5, actual=0, index=4
> Failed validation: expected=6, actual=0, index=5
> Failed validation: expected=1, actual=0, index=7
> Failed validation: expected=2, actual=0, index=8
> Failed validation: expected=3, actual=0, index=9
> Failed validation: expected=4, actual=0, index=10
> Failed validation: expected=5, actual=0, index=11
> Failed validation: expected=6, actual=0, index=12
> Failed validation: expected=1, actual=0, index=14
> Failed validation: expected=2, actual=0, index=15
> Failed validation: expected=3, actual=0, index=16
> Failed validation: expected=4, actual=0, index=17
> Failed validation: expected=5, actual=0, index=18
> Failed validation: expected=6, actual=0, index=19
> Failed validation: expected=1, actual=0, index=21
> Failed validation: expected=2, actual=0, index=22
> Failed validation: expected=3, actual=0, index=23
> ./ncdevmem: validation failed.
> 
> I haven't debugged issue #2 yet, but both need to be resolved before
> merge. I'm happy to provide more details if you can't repro. My setup:
> 
> mina-1 /home/almasrymina # cat /boot/config-6.12.0-rc4  | grep -i ipv6
> CONFIG_IPV6=y
> mina-1 /home/almasrymina # cat /proc/sys/net/ipv6/bindv6only
> 0

I see you've fixed it out already in a follow up, will pull in the fix!

---
pw-bot: cr

