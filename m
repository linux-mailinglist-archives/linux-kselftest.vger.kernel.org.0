Return-Path: <linux-kselftest+bounces-25738-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A72A27BC4
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 20:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECFB83A290F
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 19:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE1D21B19D;
	Tue,  4 Feb 2025 19:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmY+l3/s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A337A21A425;
	Tue,  4 Feb 2025 19:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738698224; cv=none; b=Ea3AWqvn14Z7zlfXDpp72gW0HNJamrhY7VD1wiuvKuoiY+glzjCQ0VhQZAMPWFwCuYdpFX7DtSoq6Sd45aYLE8XZScr1+VDtclHeda6REIGqW6/QxWWa5qpHnG+kzbN8f3/DdC/XJB30jwO90cbck0AWtCfVlIe6lIQoR66feL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738698224; c=relaxed/simple;
	bh=BkVFf9SgaGewvsLziisUAPBhil8VvhgoivOQ/8WRK9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Apti+7Pmbar/dfMcnpBx5ctzUZrRaFh3fbyVHuPmuWhy4718hgQQ1U1skqp/E9bynYBquEGG3VJCjgkl6pxWVuotFKPvDWYf3faVUKK3sgaT6JKynUvSRZaRCvCMlMsFgpGNzqelV1fg4grQRIcSF6fxEbNe17s+Tdwwzl9svRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmY+l3/s; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2f9d3d0f55dso949279a91.1;
        Tue, 04 Feb 2025 11:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738698222; x=1739303022; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SSuTIqVwgVdgeJ08MxBmbfomDViFrnj62vGl2fObfPU=;
        b=EmY+l3/svNbf7pkBy+FGjBT/E2HgXMdu+dJVpFPICi+pDH+oEqwHrwF09uQKT8o+v1
         JIkW0Zqy94LGeQETgF02nG4NYvhiW6M08jWE6kiaBHs5/hFHdoEfrq4owO1XTX8QF668
         7iwMXsjK9r8cMr7EdIZNkb5fW4VFJuqKAoLG+wvrutLBMJxKLpqiK/vXMLx1iNxmxlYl
         aSVr9hFo4G1aXzcIJWlEyoa4ga/yHKPKFzuGZYwgkc9pRoaThKjnTxMjqz/d18caDgqb
         v9s1Guc4GZ/9ikPxLZT+uGIqC9Pq30uyGMqiO3O09UvjNyBnQVQVnZGGyF+YxkLnOdVJ
         24RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738698222; x=1739303022;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SSuTIqVwgVdgeJ08MxBmbfomDViFrnj62vGl2fObfPU=;
        b=dfiAS2+6hrFQF2JuBQ6FxdAliQxKM5wT0MUssIfXtkK/JQhFmXMGWBUpTg+rW2+VcN
         7jxwLiDzpJEXYodR5z8rU9jVzzk5Q6bEdw8XDZ9qQlFsEEkS7pJ4VRD38pvLxg5GI4cn
         /I8YVCstjMcepS0PMKPvAW/XQvUb/ho7Kjk5bNMZryEtuklA/jjr4rbr2ukyEXPe9TUF
         OIzU7mHpUaBz1Lh95S6J+CGqA9cAN0Gdh5dqbfDOSjAXzHo11RS8SKFL2PmcYTzurNC3
         6ZLhfHRsyUQuPmDYcFYp8c7qPnUX7uvH7l6eu3XlSaocJGAJJ7dLQp1PgGTgOaDhW9Nh
         SjKA==
X-Forwarded-Encrypted: i=1; AJvYcCUEUDul7+hx2wY1f7njFtX6dEW17ydk2m6IWwWyIyqSjV3kz11Rpqth2dHUOgzonpLHv/Aamh9Y74x8oYXatZYI@vger.kernel.org, AJvYcCUja3XUsvXWsPl+QPRNGY38axfJkdrtXeUhLLuKKvsdBW5g8XMK7t1D0rjpWdiGKlAh1cgk+fHd+la0@vger.kernel.org, AJvYcCVuU2SoNx5C2JJOojeMKeCAaaToS+KM1UQq5JE5dYEHr11BZ3EfhFi/5hngbtj9qEO7VO0iqKOSN8UHLPtI@vger.kernel.org, AJvYcCWBcXmeXirSolqjZ2DJc+myR7cOtnwUSAh8TRPx+3CKIgZNVtiaj7Iafb8yITcvTa0oZf8=@vger.kernel.org, AJvYcCWobvp//ZZ07Cagt0NoULAUA6lV9b6dmXWP0YduyCiYmAVC6hZYfk5TQ31BAdeoT/rdUMCtqx1b@vger.kernel.org
X-Gm-Message-State: AOJu0YxczEmyhd53B80d6S77sHCzKZh4myQ8ZXDitJb4oFRl9+Ni3Qym
	ZcM64vAQWyKg0N19z60mF1dphpvsyCzeGbL7Yv1uKqk/6PMXUxo=
X-Gm-Gg: ASbGncuiDT6b/BWIrYl6dhKjtyI2W51F9PgaRs2uqUYWeAwfuhEqJXW9hHNzue1YbaH
	TXst147IT8qPgmPk7Tl49POP5dOsaq4hYRnXbWvoJOYD7tr83MxqVRygTAHYuGrhocvru9ovrU6
	EW3CyZ4srHFQSKKbR7NuHc/O7edrW1lKol4q3Zqd18Rb3vJd64tecC1/x/e9tEDsTNiqFTnhbwN
	MTb2JpakCqWRKQzyaSIkQflnJAE2yYUD17JydeuVRnMFUTKJq5iXPogD13Gtk1kpM6nUdfeALMa
	tAWZDZNiUR1qiY8=
X-Google-Smtp-Source: AGHT+IFw5vELY1t8zeAylvcZU4/cTC1NlCspjFYLf5FztuWCZwYFDQmuC9HhKFdTaKSeggS51DEKMA==
X-Received: by 2002:a05:6a00:4644:b0:728:e27c:a9bc with SMTP id d2e1a72fcca58-7303511b7f3mr255320b3a.7.1738698221666;
        Tue, 04 Feb 2025 11:43:41 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72fe69cf147sm11179288b3a.143.2025.02.04.11.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 11:43:41 -0800 (PST)
Date: Tue, 4 Feb 2025 11:43:39 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
	asml.silence@gmail.com, dw@davidwei.uk,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH net-next v3 0/6] Device memory TCP TX
Message-ID: <Z6Jt62bZEeHnN1JP@mini-arch>
References: <20250203223916.1064540-1-almasrymina@google.com>
 <a97c4278-ea08-4693-a394-8654f1168fea@redhat.com>
 <CAHS8izNZrKVXSXxL3JG3BuZdho2OQZp=nhLuVCrLZjJD1R0EPg@mail.gmail.com>
 <Z6JXFRUobi-w73D0@mini-arch>
 <CAHS8izNXo1cQmA5GijE-UW2X1OU6irMV9FRevL5tZW3B5NQ8rA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izNXo1cQmA5GijE-UW2X1OU6irMV9FRevL5tZW3B5NQ8rA@mail.gmail.com>

On 02/04, Mina Almasry wrote:
> On Tue, Feb 4, 2025 at 10:06 AM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > On 02/04, Mina Almasry wrote:
> > > On Tue, Feb 4, 2025 at 4:32 AM Paolo Abeni <pabeni@redhat.com> wrote:
> > > >
> > > > On 2/3/25 11:39 PM, Mina Almasry wrote:
> > > > > The TX path had been dropped from the Device Memory TCP patch series
> > > > > post RFCv1 [1], to make that series slightly easier to review. This
> > > > > series rebases the implementation of the TX path on top of the
> > > > > net_iov/netmem framework agreed upon and merged. The motivation for
> > > > > the feature is thoroughly described in the docs & cover letter of the
> > > > > original proposal, so I don't repeat the lengthy descriptions here, but
> > > > > they are available in [1].
> > > > >
> > > > > Sending this series as RFC as the winder closure is immenient. I plan on
> > > > > reposting as non-RFC once the tree re-opens, addressing any feedback
> > > > > I receive in the meantime.
> > > >
> > > > I guess you should drop this paragraph.
> > > >
> > > > > Full outline on usage of the TX path is detailed in the documentation
> > > > > added in the first patch.
> > > > >
> > > > > Test example is available via the kselftest included in the series as well.
> > > > >
> > > > > The series is relatively small, as the TX path for this feature largely
> > > > > piggybacks on the existing MSG_ZEROCOPY implementation.
> > > >
> > > > It looks like no additional device level support is required. That is
> > > > IMHO so good up to suspicious level :)
> > > >
> > >
> > > It is correct no additional device level support is required. I don't
> > > have any local changes to my driver to make this work. I think Stan
> > > on-list was able to run the TX path (he commented on fixes to the test
> > > but didn't say it doesn't work :D) and one other person was able to
> > > run it offlist.
> >
> > For BRCM I had shared this: https://lore.kernel.org/netdev/ZxAfWHk3aRWl-F31@mini-arch/
> > I have similar internal patch for mlx5 (will share after RX part gets
> > in). I agree that it seems like gve_unmap_packet needs some work to be more
> > careful to not unmap NIOVs (if you were testing against gve).
> 
> Hmm. I think you're right. We ran into a similar issue with the RX
> path. The RX path worked 'fine' on initial merge, but it was passing
> dmabuf dma-addrs to the dma-mapping API which Jason later called out
> to be unsafe. The dma-mapping API calls with dmabuf dma-addrs will
> boil down into no-ops for a lot of setups I think which is why I'm not
> running into any issues in testing, but upon closer look, I think yes,
> we need to make sure the driver doesn't end up passing these niov
> dma-addrs to functions like dma_unmap_*() and dma_sync_*().
> 
> Stan, do you run into issues (crashes/warnings/bugs) in your setup
> when the driver tries to unmap niovs? Or did you implement these
> changes purely for safety?

I don't run into any issues with those unmaps in place, but I'm running x86
with iommu bypass (and as you mention in the other thread, those
calls are no-ops in this case).

