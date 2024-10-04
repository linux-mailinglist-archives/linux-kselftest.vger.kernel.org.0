Return-Path: <linux-kselftest+bounces-19038-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA87990669
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 16:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76A321F21799
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 14:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B107C2178E8;
	Fri,  4 Oct 2024 14:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWLPWWSm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34153212EFD;
	Fri,  4 Oct 2024 14:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728052890; cv=none; b=h+O28+C0nZAiMtU2VTByPcuWYXrvJrm4eMyjKWV5+b620ZHoNeZVmTW8YR0zabxqtOKX6Gu9/o5tjKaAY2QqauwwU3MxxszYkY3sS7D2q6ycqUJo7kJ3EGQqmOg3Sr4Zxb+bN3KLcnX1G5ENeN5nNKCVIfdoS5xBF2vW8mSz19M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728052890; c=relaxed/simple;
	bh=6vZ9ZZ2+8UkQgXbyVgwYaztAjeD8tlbGKHEGBkwI3R4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SoHns1Rg9eQbgvl7IQiaoIsPnKmrTwniXMEz1gq7WZROaEsNeIclp5rqy+qMnXT3d0A0PfQ1qXhSZz6tf+0aQmNDOScWx9KmYYMTWCeAYKWpgpMfgDBBOcEcYGhVNSyARxAkru10fDcFF8w0R84d3GlazVZPg3JvztfLi+AnAlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWLPWWSm; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2877d7ae431so1179780fac.0;
        Fri, 04 Oct 2024 07:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728052888; x=1728657688; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WpwvhreYRuWCJg/9GLsajWKdBRP2ezNYkowaWEKQfpQ=;
        b=BWLPWWSmU+V10ELkaXZENURLNWQbfEEG4wgVDuYOGF741EKtwCumXJqMzmY9RDhe3v
         rHUT6UmLxb7vAA0jFt4FHeL7zDdCmfzR75tKoAEu1/kku1Kl+zd4+QglWaxEp3d4ym0N
         5Fg4vuA3wEBVXwW2d4oiH8nvPLn9anNp+8XylF6mskfWqgFqKOZw5GXh6BTxdDhG9w99
         Ol6LqiwUw4ukfhL1UqAOylJmNginfFwyrjB1PVldlyAESLqE3EbaXKF/4XLy504kz70+
         ZrSHR6l7s9G723jramMMQSD3+sSVqk/sKxnaVmcThZGbC7UpYqN6e2yYXkBBFvtWPy1E
         ptnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728052888; x=1728657688;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WpwvhreYRuWCJg/9GLsajWKdBRP2ezNYkowaWEKQfpQ=;
        b=nsloinMa4Ivwuf7D05pveeJK5lwvc6vsOkGt8fbFjnkAJk1eK4ne4gMsDdE2E7DFui
         04u7g0ogdgSf4z2gc6FHvfJtkeHnll4YoZhLP3Ad6SKblGxFsDGakm3Wh44qWxpl1mqA
         hxkFSgyJ+vhEIMa9GV+I8mJN8BHVP6NPwbatLk5jOV836UOoESQ017riSrLEUKVx+krT
         f/OCYaTizi2QNVIbKXKL221YR1jm0L8pSOD3hmb11hWkVtliFIydXQ5gYadr7x2ly9py
         i7Y4Bgb/ntpQMMlMsHQ/lMBbugQzgLNLP/2kvB3qC1XuxhIhAoEK7wCsogCSkdd5Q+vl
         393w==
X-Forwarded-Encrypted: i=1; AJvYcCWBfJBDDS19+KVQjh4nuOEZdxHhn7ZvSPBK18Lk6x8C7wSavAFie43INpuUwhj3dvcUomF0y0TlETdsRQ1+DGX4@vger.kernel.org, AJvYcCWs/+Uj9s5Dvuk6T7bEMo4hfxixlnOWSEHOjvnN4NNxesQ8juy5sNJJpkDcGfmrtJxybidzzf5z@vger.kernel.org, AJvYcCXaWeNnXOwkfiK2+gcSclfgHuLST0PynVx2erikNBFVDUuLUTYUhJR1h3zrr5N2Y/VDCOQYX6/FR4fIsuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN+ywtchGOUgChvPIhPkgynT2rrNTYy0lE4Ft2h++wbWHSrxri
	n9waUxEUg2/7b58zQCFJFof50y7hHmimn3SVpPzHOvOiZJcJROz6HqYyjk5nzhlY5mo/f56umvj
	uqRBIAz7xWMVcEDRvzCL4iHW4QBg=
X-Google-Smtp-Source: AGHT+IH5NERFZsDJilgPCrkzxJYp3AF3EavawqcoLwXWFg9KBsUJL305SG7pAygMndGuG5VqmupLa4rp6BmP8XW6Msc=
X-Received: by 2002:a05:6870:1490:b0:25e:1382:864d with SMTP id
 586e51a60fabf-287c229144amr2109346fac.30.1728052888218; Fri, 04 Oct 2024
 07:41:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
 <20241002-b4-ovpn-v8-1-37ceffcffbde@openvpn.net> <m2msjkf2jn.fsf@gmail.com> <20241004063855.1a693dd1@kernel.org>
In-Reply-To: <20241004063855.1a693dd1@kernel.org>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Fri, 4 Oct 2024 15:41:16 +0100
Message-ID: <CAD4GDZxR5LzEo0ksFd3FbhVpeoeEMSWg2dL_RNyFRfB2bx052g@mail.gmail.com>
Subject: Re: [PATCH net-next v8 01/24] netlink: add NLA_POLICY_MAX_LEN macro
To: Jakub Kicinski <kuba@kernel.org>
Cc: Antonio Quartulli <antonio@openvpn.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	sd@queasysnail.net, ryazanov.s.a@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Oct 2024 at 14:38, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Fri, 04 Oct 2024 13:58:04 +0100 Donald Hunter wrote:
> > > @@ -466,6 +466,8 @@ class TypeBinary(Type):
> > >      def _attr_policy(self, policy):
> > >          if 'exact-len' in self.checks:
> > >              mem = 'NLA_POLICY_EXACT_LEN(' + str(self.get_limit('exact-len')) + ')'
> > > +        elif 'max-len' in self.checks:
> > > +            mem = 'NLA_POLICY_MAX_LEN(' + str(self.get_limit('max-len')) + ')'
> >
> > This takes precedence over min-length. What if both are set? The logic
> > should probably check and use NLA_POLICY_RANGE
>
> Or we could check if len(self.checks) <= 1 early and throw our hands up
> if there is more, for now?
>
> > >          else:
> > >              mem = '{ '
> > >              if len(self.checks) == 1 and 'min-len' in self.checks:
> >
> > Perhaps this should use NLA_POLICY_MIN_LEN ? In fact the current code
> > looks broken to me because the NLA_BINARY len check in validate_nla() is
> > a max length check, right?
> >
> > https://elixir.bootlin.com/linux/v6.11.1/source/lib/nlattr.c#L499
> >
> > The alternative is you emit an explicit initializer that includes the
> > correct NLA_VALIDATE_* type and sets type, min and/or max.
>
> Yeah, this code leads to endless confusion. We use NLA_UNSPEC (0)
> if min-len is set (IOW we don't set .type to NLA_BINARY). NLA_UNSPEC
> has different semantics for len.

Oh, I see it now. So it's dropping through to here:

https://elixir.bootlin.com/linux/v6.11.1/source/lib/nlattr.c#L555

> Agreed that we should probably clean this up, but no bug AFAICT.

Yeah, it's definitely surprising that the meaning of .len varies.

