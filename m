Return-Path: <linux-kselftest+bounces-21131-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 002369B67F9
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 16:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B23B1C20FAB
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 15:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5052A1F4737;
	Wed, 30 Oct 2024 15:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qb/12Uin"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFEC2C6A3;
	Wed, 30 Oct 2024 15:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730302632; cv=none; b=UizKU9i6a8pJBh2qpk5esHy40es+vqWAZvESeM4WGKiC9CG/c3zXWL8WKGN9DLI220VW1KhkCuwbUwvn7LgNkls+cdKG6AsojMAP7cX0rp0fmyDZlyD5VcKlCS7xCNT9VtxjPcyQpIpCo4GSisBRzFmrJHxZSgkwKPB6+n/yKIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730302632; c=relaxed/simple;
	bh=jsll4iE1W2vc5wqDh6vKsydyOvjcSPJ7tW7yaYX8bCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUMK78Mm0/fXDdou+LwtkerpKDLIxSzkGRIWF0oX/08cfsswjtO48EeS8LC2kIRZOXZJFNfyBIvZwnFUwnZJdRJHXJfYVs+9fwe6d6oSSFbzI6MqzXsxnpQrrk/FIzKlRSIPgsOW9VD8CkYiSeRXgSHVjxs7XbOYem8BEajSsMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qb/12Uin; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7edb3f93369so21428a12.1;
        Wed, 30 Oct 2024 08:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730302629; x=1730907429; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qRgFGBcG9N2scOzZ+x26NTz7+MUkQBjpLYs7QSpsjkc=;
        b=Qb/12Uin85auYVP7smHFW8Dodn2q7hsHan8IWTHDDJ9IpDYRfk0OwMMRVpxqZWyumw
         v33YLsZqVGepPrU4s1LZ5F1I+cmgVUXlQjQGEY6WpRfhoWtR6mgEfpKcV8eKlSDQd6V1
         eMDYipzB6BUUzhFe3xYVgzUn0nwMfuCA+KpClm9O4FKD2aawkxFXhU+0UFuGUKLpDzE9
         1plX6SMNZclvuJCfetKW79KBJzo2HPOZk4IwPdWI7F6gIbfUni/q+MAHo6yT3WXbhN81
         KGWGELlQSIqpMS9sFEkiBX1SlBxE1ej27TUUGS7g9mqiRSoRReSgmf16oCBZ7q0b/R5J
         ue+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730302629; x=1730907429;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qRgFGBcG9N2scOzZ+x26NTz7+MUkQBjpLYs7QSpsjkc=;
        b=KKUiZrxp2cyLEbnPb2u25pUag+ap+UFYXlw/GT7XPlkj+BOKJtu1+Haq7WQ3Enh+2Y
         OQ9Wq49XhW7NYNAgmymsxw5PpKH8VjeUfIdvdpaHp5H9KcMq3y+etxVDfb4HFE/t0yE9
         W4Q4+abck1GtEMltJ/Drsm25tAKeSSiNGdRLT/+LdcnJvslHm0zSfmsOJG8qk/Q0uzIU
         Vxbp+vMng09U/LEmR8xm7TXZmR0RI8gZtxFoeCk3PFJFTc3od8hg/4+dpqDOEGnwmyG3
         X5NJSg+p63Pz6XkmHHnavIJ/PQuB8k0l8l8EcIsrA0BbEUPrp0WgeZAbHr4+YbGCQAor
         LdTw==
X-Forwarded-Encrypted: i=1; AJvYcCUMp08Jyc9ydDLm31q3WZ0lNzk01TdW/sAvhzqytx6QpeIzGrwZ7slUL/AokwMB9CnM9lnn8CdVy2/QxtxrIxVu@vger.kernel.org, AJvYcCVBT4EM1SNczIPnmBZ0S10Nt2UN29bDefhLODnOTSa4trC95ysgt5GVMCYD3qZDExtmGv7wRlIF@vger.kernel.org, AJvYcCW/RKkWnzkjpu6Nfn7F4nEP/beRUv4U7tOvhVdFtnume0zHDDUhCKWAAkYiK6FbFOPVmXuXTkG/EAbKacU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmGc2J5sBe4z09FE6rY8hjFbHI/v2IfyWxxwmiTDawhDuoH+9A
	nYVHN945jglT9r/jdAA9jWBYaWSq34BmfUz53pVXIf8kZdkwP6A=
X-Google-Smtp-Source: AGHT+IHMgfYhqtG/HeD4IkXQKmRqZBm1ETzBUyPWZsG0ycjcyLfBwQroJVrhMWh2VNGZ4DMQG6jyjQ==
X-Received: by 2002:a05:6300:4041:b0:1d9:2bed:c7e5 with SMTP id adf61e73a8af0-1d9a84b89bfmr21656776637.40.1730302629584;
        Wed, 30 Oct 2024 08:37:09 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a0df99sm9405125b3a.118.2024.10.30.08.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 08:37:09 -0700 (PDT)
Date: Wed, 30 Oct 2024 08:37:08 -0700
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
Message-ID: <ZyJSpBrhz7UJ0r7c@mini-arch>
References: <20241030142722.2901744-1-sdf@fomichev.me>
 <CAHS8izOBp4yXBg-nOSouD+A7gOGs9MPmdFc9_hB8=Ni0QdeZHg@mail.gmail.com>
 <ZyJM_dVs1_ys3bFX@mini-arch>
 <CAHS8izN6-5RJgKX08sgntYDVgETkBGpgoYToq8ezcy+tYHdaSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izN6-5RJgKX08sgntYDVgETkBGpgoYToq8ezcy+tYHdaSA@mail.gmail.com>

On 10/30, Mina Almasry wrote:
> On Wed, Oct 30, 2024 at 8:13 AM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > On 10/30, Mina Almasry wrote:
> > > On Wed, Oct 30, 2024 at 7:27 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
> > > >
> > > > The goal of the series is to simplify and make it possible to use
> > > > ncdevmem in an automated way from the ksft python wrapper.
> > > >
> > > > ncdevmem is slowly mutated into a state where it uses stdout
> > > > to print the payload and the python wrapper is added to
> > > > make sure the arrived payload matches the expected one.
> > > >
> > > > v6:
> > > > - fix compilation issue in 'Unify error handling' patch (Jakub)
> > > >
> > >
> > > Since I saw a compilation failures on a couple of iterations I
> > > cherry-picked this locally and tested compilation. I'm seeing this:
> >
> > Are you cherry picking the whole series or just this patch? It looks
> > too broken.
> >
> > > sudo CFLAGS="-static" make -C ./tools/testing/selftests/drivers/net/hw
> > > TARGETS=ncdevmem 2>&1
> > > make: Entering directory
> > > '/usr/local/google/home/almasrymina/cos-kernel/tools/testing/selftests/drivers/net/hw'
> > >   CC       ncdevmem
> > > In file included from ncdevmem.c:63:
> > > /usr/local/google/home/almasrymina/cos-kernel/tools/testing/selftests/../../../tools/net/ynl/generated/ethtool-user.h:23:43:
> > > warning: ‘enum ethtool_header_flags’ declared inside parameter list
> > > will not be visible outside of this definition or declaration
> > >    23 | const char *ethtool_header_flags_str(enum ethtool_header_flags value);
> > >       |                                           ^~~~~~~~~~~~~~~~~~~~
> > > /usr/local/google/home/almasrymina/cos-kernel/tools/testing/selftests/../../../tools/net/ynl/generated/ethtool-user.h:25:41:
> > > warning: ‘enum ethtool_module_fw_flash_status’ declared inside
> > > parameter list will not be visible outside of this definition or
> > > declaration
> > >    25 | ethtool_module_fw_flash_status_str(enum
> > > ethtool_module_fw_flash_status value);
> > >       |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > /usr/local/google/home/almasrymina/cos-kernel/tools/testing/selftests/../../../tools/net/ynl/generated/ethtool-user.h:6766:45:
> > > error: field ‘status’ has incomplete type
> > >  6766 |         enum ethtool_module_fw_flash_status status;
> > >       |                                             ^~~~~~
> >
> > This has been fixed via '#include <linux/ethtool_netlink.h>'
> >
> > > ncdevmem.c: In function ‘do_server’:
> > > ncdevmem.c:517:37: error: storage size of ‘token’ isn’t known
> > >   517 |                 struct dmabuf_token token;
> >
> > And this, and the rest, don't make sense at all?
> >
> > I'll double check on my side.
> 
> Oh, whoops, I forgot to headers_install first. This works for me:
> 
> ➜  cos-kernel git:(tcpdevmem-fixes-1) ✗ sudo make headers_install &&
> sudo CFLAGS="-static" make -C ./tools/testing/selftests/drivers/net/hw
> TARGETS=ncdevmem 2>&1
>   INSTALL ./usr/include
> make: Entering directory
> '/usr/local/google/home/almasrymina/cos-kernel/tools/testing/selftests/drivers/net/hw'
> make: Nothing to be done for 'all'.
> make: Leaving directory
> '/usr/local/google/home/almasrymina/cos-kernel/tools/testing/selftests/drivers/net/hw'
> ➜  cos-kernel git:(tcpdevmem-fixes-1) ✗ find . -iname ncdevmem
> ./tools/testing/selftests/drivers/net/hw/ncdevmem
> 
> Sorry for the noise :D

Whew, thanks and no worries!

