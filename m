Return-Path: <linux-kselftest+bounces-21127-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2FC9B670E
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 16:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F805B20FCB
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 15:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8F1200B8D;
	Wed, 30 Oct 2024 15:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfh/MMEB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1F31F4737;
	Wed, 30 Oct 2024 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730301185; cv=none; b=lr555mueiV2dcXUl/qbtNOCS6tiiKJJtJhuF1dXQHqvbb3DjT5b9LxstCb9DL1HvVCVL+9OiR1hjCWCqwcVRFR9Tyodu6uR+g3ONb+sKqR227NY/fN0swdlZxu3qf39Yn8YQmMN+AVuKedKqwYufQCY/S06LbNIhCYW/f/h84uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730301185; c=relaxed/simple;
	bh=RNKNkA+2ttAQAEtrEr7Oe6nLWaGzj+yskaJCrJZgZjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPHj94dlc86WKd52jw71amh+YTVQsGNIlpNmDKAO9kF2abT0f8qOvPnsem5OMyWVXWUM25e7GWnohkhmvgX0OE/dg0dZiIDPFP0zeJ1OmTiV9eItZrdCoIRcrgZ6Rq+Ei/Wd5BAo1whsxfAT5TJUXJOkcdsqIA8kskNvlAtgOsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfh/MMEB; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e2bd0e2c4fso5484405a91.3;
        Wed, 30 Oct 2024 08:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730301183; x=1730905983; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WZrpf2YEVXVi1ylfAwlcjfSMS6TdCMEyz7I5Rss6TC8=;
        b=gfh/MMEBT/Ropas4ETwrTY9Z/sDWMm4fzXHReQZ/rvZiAaoI4IRF9DNJJowVduVqla
         Z38+vOtRI90kMC7qFnk/jP7pzvewvGw8gQGJUz95qlh1o3v4KBmHK0wwgqcEzwzJ0p5/
         /HHcJAYMQHCQdNCn92rk5TL4U/dftIyiJz/rwbSUgv0kNSl8vygLxMQdq/cJaoAYLbE4
         7NJXTL/QIrKxPatM4D5EHBA3zZNRCaxAajH8RHP5OUsLaWjfh8EF0tjdMbLNqp1gf7Qq
         k4qX+YPP+hQolz4xk6qkjvck0sHTXmmoTavZYoLXdXsQ9G9gRdQUKRoeRel2SlANHsDF
         tPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730301183; x=1730905983;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WZrpf2YEVXVi1ylfAwlcjfSMS6TdCMEyz7I5Rss6TC8=;
        b=wTXs1YhSRUOZ9QgKWjc0Ae/kQJUH3ZWZG4uR9v9qLRL1tz1xl/B56qJlHD0zEtVSvt
         ubkNI+n5mKUaK800dp5+97A4MpnoeZXB0U0rO29l27I63ehBj6L4ZnoaGE52Vby8OK0n
         Gv0y1Dtc4t8gH0BC7+/BWyxWXqFUtkvXQEqhfcupg0iHx9TQcqC/EUa5wMrqPFAy0s64
         ILSgI+JRtByOrd3dfGXvoqzuFUZPQSPeh/NVMK5TgnOYwLrh58QlOZzDrANWrBzlBYkS
         X0eKhtyJHTcDj+L/+uR6A/YeKYQXX+k5aEOztn5Ppa9CZgkwgD7+BSIglvjOn6Vc8R8w
         PBgQ==
X-Forwarded-Encrypted: i=1; AJvYcCW920EKopsScnD8deFKhQtKQ38txeylfI857hOEgtzTA80hdaPEBGqBgU5xh13pgP1Xc1rndVCS@vger.kernel.org, AJvYcCWgv8lgT6D6CWZTnZzHOmg1pqZubCUEI9Ey/+v6bTjRkOTVN6lqQyrn6LTjMH06puePU+jyB3VKeQJxfR0=@vger.kernel.org, AJvYcCXfdfZnGm2x0S+hzo+gtrSgc6LTZHEt42+ya+6Df9bP5U1sI7jW+t9sAUj0i+0aGIJ6kdizBad26lBsYuAz6A5v@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/riEjSgGrK0/g4f/Owb2nYjVa/4gHRsbjyvQ0bQTv4PwmimAc
	kxXzYo/vacKWugP527i2Ty1BMofcT5ImI7fiVgI9nnCl4sVmMGg=
X-Google-Smtp-Source: AGHT+IEWN/FKVv3b78SqmWOIr0ZImsElU8WqdYGBFfwTLQkrXEFi4uz+9nfGgKmg9BHiIMFjBxterQ==
X-Received: by 2002:a17:90a:f2d8:b0:2e2:7f8f:3ad7 with SMTP id 98e67ed59e1d1-2e8f0f52f4bmr17997710a91.7.1730301182856;
        Wed, 30 Oct 2024 08:13:02 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa1cb3bsm1840127a91.10.2024.10.30.08.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 08:13:02 -0700 (PDT)
Date: Wed, 30 Oct 2024 08:13:01 -0700
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
Message-ID: <ZyJM_dVs1_ys3bFX@mini-arch>
References: <20241030142722.2901744-1-sdf@fomichev.me>
 <CAHS8izOBp4yXBg-nOSouD+A7gOGs9MPmdFc9_hB8=Ni0QdeZHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izOBp4yXBg-nOSouD+A7gOGs9MPmdFc9_hB8=Ni0QdeZHg@mail.gmail.com>

On 10/30, Mina Almasry wrote:
> On Wed, Oct 30, 2024 at 7:27 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > The goal of the series is to simplify and make it possible to use
> > ncdevmem in an automated way from the ksft python wrapper.
> >
> > ncdevmem is slowly mutated into a state where it uses stdout
> > to print the payload and the python wrapper is added to
> > make sure the arrived payload matches the expected one.
> >
> > v6:
> > - fix compilation issue in 'Unify error handling' patch (Jakub)
> >
> 
> Since I saw a compilation failures on a couple of iterations I
> cherry-picked this locally and tested compilation. I'm seeing this:

Are you cherry picking the whole series or just this patch? It looks
too broken.

> sudo CFLAGS="-static" make -C ./tools/testing/selftests/drivers/net/hw
> TARGETS=ncdevmem 2>&1
> make: Entering directory
> '/usr/local/google/home/almasrymina/cos-kernel/tools/testing/selftests/drivers/net/hw'
>   CC       ncdevmem
> In file included from ncdevmem.c:63:
> /usr/local/google/home/almasrymina/cos-kernel/tools/testing/selftests/../../../tools/net/ynl/generated/ethtool-user.h:23:43:
> warning: ‘enum ethtool_header_flags’ declared inside parameter list
> will not be visible outside of this definition or declaration
>    23 | const char *ethtool_header_flags_str(enum ethtool_header_flags value);
>       |                                           ^~~~~~~~~~~~~~~~~~~~
> /usr/local/google/home/almasrymina/cos-kernel/tools/testing/selftests/../../../tools/net/ynl/generated/ethtool-user.h:25:41:
> warning: ‘enum ethtool_module_fw_flash_status’ declared inside
> parameter list will not be visible outside of this definition or
> declaration
>    25 | ethtool_module_fw_flash_status_str(enum
> ethtool_module_fw_flash_status value);
>       |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/local/google/home/almasrymina/cos-kernel/tools/testing/selftests/../../../tools/net/ynl/generated/ethtool-user.h:6766:45:
> error: field ‘status’ has incomplete type
>  6766 |         enum ethtool_module_fw_flash_status status;
>       |                                             ^~~~~~

This has been fixed via '#include <linux/ethtool_netlink.h>'

> ncdevmem.c: In function ‘do_server’:
> ncdevmem.c:517:37: error: storage size of ‘token’ isn’t known
>   517 |                 struct dmabuf_token token;

And this, and the rest, don't make sense at all?

I'll double check on my side.

