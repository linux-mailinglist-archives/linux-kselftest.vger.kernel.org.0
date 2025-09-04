Return-Path: <linux-kselftest+bounces-40792-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2916B443B9
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 18:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8279B165EAF
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 16:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6412F5313;
	Thu,  4 Sep 2025 16:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmGmDhYC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAC022B5A5;
	Thu,  4 Sep 2025 16:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757005078; cv=none; b=CPGXoEViShmoPOVV3cfGdcIYSvaqExizehlpEupxzrrtYFgbN+WFP55LPW6+s3XkGD7yxKrGF4jsNCBs+V9u+sa8SFYTbqQn0h+K88GrwT0HmwKCKGCJK1oPaCNL9yNYnKsoi/PQcfhxZC95eaSrnR8/MMs1DxM36YUW/Rx4PKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757005078; c=relaxed/simple;
	bh=ouXa+buHgPojnDxUmIhZfwT7/tCXbaUJ9leCQVUxMrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c88DuJf+218spyX5SfHnWv0VZbldPCkmQMioTmV4xN6Mi774Uo3CYZu3hLVEefMtypFjyuIrQGPGAmJgSRjYY1/qh2nKm3Epyu35snIOS2qu5+/+tM1wP19fuBg64wAzZGswYI9/vrBbJWa92W4nUIBbccO6oEZOCgSDzs4A+M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmGmDhYC; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e970e624b7cso2084853276.0;
        Thu, 04 Sep 2025 09:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757005076; x=1757609876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=irrrx3eJCz7Erx4j7m6TJA4T3jMD95DmIwByWZVQujs=;
        b=ZmGmDhYC4FKKr34aUZ3gxlg8KV9ki8YenSQeulzGVo31iX1JmFidpHNHKOCRVJ0RRi
         yT3Y/a/swAECjztVN9lFVO2Mw/gguic1widcd02YKwftXE10zxg61a7SKAHk53fKxSmh
         r5Wj3aIzaqdImT+0KDnCbS9LYwQ8j7OxWrBLWTEc2TkOOaWyhyz3XK++MbKcfOukKWQ+
         hEJ6p5O4ir49lc3mzLhelgUl6QAqjerAzCFdKR8CF0DZM8OufhVN7syFFKrmJgm4SfLw
         rYdzHdf8+x2sMThBEMSocycJSXkWs6iTkE0ORmm50HtxGdsCIDZSPcK62Qa4bCzG//bN
         sBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757005076; x=1757609876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irrrx3eJCz7Erx4j7m6TJA4T3jMD95DmIwByWZVQujs=;
        b=nOKY4q2kC5LO74KNVqUhfz8WRIOqqBjl1Q/xSlkxUsPyTBo+yQzKiCiRMoKx7Zrz5y
         QWKkyiPiItJSKhGlsOrr6CM0Tqbu8Fgk+sEDb8191L90uanYoOp17ZeGNQP5qCTLmoCV
         xoiFmSr6hDFFx7jdYmeif+DNR1u49nPzt5awKtBYHe3Vbfpe1gV7y+Suset7gXA+ezvj
         iKx+9SHlatV5FE8an6i9brFdzqcsZrOsOy5dEbwdGgaouYY5HuHsLEu3zT/hGG1JZMeN
         XurPzDNv4pjJtkEkQKsOS0/P/z2YQQlH5ywRGeApIQnQ/mseeX3Go5g+NLRDOr7CDM4M
         jNfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6TXwY2g+LIr/aAlSKALyPPV6jz//4maa6/j4RMIV/EoAVLcvgAhBCIfpCGzn0+F6Lh1AgD3yBQ2E0CYK/@vger.kernel.org, AJvYcCUXRtkdnip4BBkMrmakC9IFTHd1sVMOTWCSrMg6GQg9WuwV+c+3azYd9pNgOiOWA3drCe17Sumt@vger.kernel.org, AJvYcCUrZn9iG2PkHDEzKp+ncaXmHFqkzPg1vue7Io/NnGt4vpIJ9Wfo4k2lE/4gZbrQhg8GfBu6k34A38dCPN2oxEZZ@vger.kernel.org, AJvYcCVmMhOrSHuRGgorNbHjWGbW9MyddwxPw/swNmumewZzyetFKishP/Lpm+tksyyfkp1hAcE=@vger.kernel.org, AJvYcCWCG9hbqiQkfYIUmLRsNVrWKqag20xciHU/E4qtPeI3BPNhYEKfbEeAaY7VzbYlJ77Cr0mgJZ2LVHP2IC/+@vger.kernel.org
X-Gm-Message-State: AOJu0YyADlrqTt/VlwTIwSAM+w3s0kM4IegRMbfvlfprzPJSX465KKWq
	Gdtv32q64U5NBzRtZ5tpRXRqSwIzroQIBK43AF6dI9wulpQb1NyzMVDM
X-Gm-Gg: ASbGncuCKWGrKoiAWBLZVCBHfG8s6u/e7CpfkcgWArVOg7lE2cBdbEKpvG9JFVz8mAZ
	5Djieciur6eG/5jAy3DVSmWi9q2RBO6DpRIyZn52Ml1a9/JJ639XUu2TBOhcxQzNuLjKQ2Iftm7
	TIHqkBtgV8AiG7VtQDd7P0y0yY6XzUvhp2MPQ5zOOHe8I+BhdQJD0ak6MK3/P/mAeZDMt/ykoSU
	pMJwNUEZ4Xw5qnkd5PKw8SKHzIgG5rG46h64Bqvnevkm5lUQaQVTYaY0gRZIK0pxS/531hU3FxF
	UEOqtdNgQtf6rIN9aRPotLWRH8EwLYV6ySeLuhJzMOtzCi+CdFc+6jOlssKoE2PEH2txQMo/STU
	XuLFOvjga5MKsbOpty7pe5XnmwI7U52x/2kiFW2xwI857ruE=
X-Google-Smtp-Source: AGHT+IH84tU1qbIF/86A4dwkWsNLS9E7ptPPrXXDoSkNZ0JGyACTTGW1vQFLOTahp7MDXGWvzB7z0w==
X-Received: by 2002:a53:bac6:0:b0:5f3:317e:40c9 with SMTP id 956f58d0204a3-60b699833femr293555d50.17.1757005075778;
        Thu, 04 Sep 2025 09:57:55 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:73::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a8503294sm22857357b3.42.2025.09.04.09.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 09:57:54 -0700 (PDT)
Date: Thu, 4 Sep 2025 09:57:53 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v5 4/9] vsock/loopback: add netns support
Message-ID: <aLnFESZSETzh/jMh@devvm11784.nha0.facebook.com>
References: <20250827-vsock-vmtest-v5-0-0ba580bede5b@meta.com>
 <20250827-vsock-vmtest-v5-4-0ba580bede5b@meta.com>
 <mhjgn7fdztfqi6ku3gesgd42jj5atn4sqnvpyncw2jds23dpc3@iiupljayjxs4>
 <aLcy4Kk0joVPbxkd@devvm6216.cco0.facebook.com>
 <yuumxtgizcrkn4uspczro76p6u2dqvra5otqkrb57bi2se2lpx@zg4f4rtix7hb>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yuumxtgizcrkn4uspczro76p6u2dqvra5otqkrb57bi2se2lpx@zg4f4rtix7hb>

On Wed, Sep 03, 2025 at 05:10:31PM +0200, Stefano Garzarella wrote:
> On Tue, Sep 02, 2025 at 11:09:36AM -0700, Bobby Eshleman wrote:
> > On Tue, Sep 02, 2025 at 05:39:33PM +0200, Stefano Garzarella wrote:
> > > On Wed, Aug 27, 2025 at 05:31:32PM -0700, Bobby Eshleman wrote:
> > > > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > > >
> > > 

[...]

> > 
> > I could be wrong here, but I think net->vsock.loopback being set before
> > vsock_core_register() prevents racing with net->vsock.loopback reads. We
> > could add a lock to make sure and to make the protection explicit
> > though.
> 
> I see, talkink about vsock_core_register(), I was thinking about,
> extending it, maybe passing a struct with all parameters (e.g. transport
> type, net callbacks, etc.). In this way we can easily check if the type
> of transport is allowed to register net callbacks or not.
> 
> Also because currently we don't do any check in
> __vsock_register_net_callbacks() about transport type or even about
> overriding calls.
> 

That makes a lot of sense. I'll make that change if pernet_operations
doesn't solve the probelem.

Best,
Bobby

