Return-Path: <linux-kselftest+bounces-5519-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B43B986AA4E
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 09:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45118B2617C
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 08:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56562C85D;
	Wed, 28 Feb 2024 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdhYCy1B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048282D622;
	Wed, 28 Feb 2024 08:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709109738; cv=none; b=PeZGbZOyzOKUZHt9Fr2g7xjrOkdfJxqVF8BN8TW0Zh2B6LeBYEhWqUbxgFzd45ZJzHIrcnIbCrqLisSRHu/KXYi5f/jpOC+4+cgmBgMlBR1FE6nZW75VmlpP4kvVfu5aL6qS9L8H91XXUnNt67HPkRGdB9Mhi4kFNKZ0HGIl0oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709109738; c=relaxed/simple;
	bh=DKje+K8ippA0ZYfJntuI0R7Vbe0XtsQE0B+iMwY1OGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZzxWcOwjdbZ3O/7O/Yk5RN+TppKEkZBGaMtgrrI0RC44mSjR5ySKDML3rluhlAHlJEmrR++0/KDKuvx0iM711WB9VfyFTrl/DXC1ZQum/oex42ChV0jN8NdrX4Yni73ZTTWDvP1OUc9iqVVvkNuzMDNl8Vw6Zv+ZrE3actuV0e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdhYCy1B; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-565a3910f86so5863803a12.3;
        Wed, 28 Feb 2024 00:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709109735; x=1709714535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/Z7R/WO7svFjmJZnbr0mJ+YCtxsZi714lKpVsB3CcM=;
        b=cdhYCy1BcrCdUPa7udojTVvrSWDD+75lTtba8w1X5khpZBSHe2bZwY4zBYRfJUxAhU
         k/klnnPvzWT+vcfDTmT6wriP25aF5Gw9Y1DWHv6GhQA4Bq8nnoPHMHY0/6eInice6A7/
         XjY84lqefh7KBem8SbsL4Lx8WnIwd9Wpcedxbj5OUNmupjCiz7cQToaisqzTTOKkQfpB
         IQU/t/ys4kg5LCVKdfQvo0ZuUIFNU7B8lYdBD2Nu+h4frSh8WfA1moec7ea4YKg4cNQH
         /WRxyk7JWd+5frAPLi/VNtokkB97LS+83ldO2vWcn+ikNkPHgHd0hj/a3TmQaOMNzhOh
         Vbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709109735; x=1709714535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/Z7R/WO7svFjmJZnbr0mJ+YCtxsZi714lKpVsB3CcM=;
        b=MP8BSnkGXE2RZMQqtfkOUNdAaZRcCNoAmPbv28L+KVXYdPChSaXO6G6Y9Jty6gNg4q
         4Lzfhr7jber82+/K4v05OjEKIS0oK6IetGnxYbxe48cM3RFQtAeQYENs9gx14pPFXg4G
         gTcSHsodpC7GjKsDlNsB8UbIUqwAn/FymVdtUTB2JlEPOhNIA+6fhFWD77+48oy7eX9U
         QyeFQHfrIPfcMih9eI7y2O2949zIRlJTWKeHWWZ7p/XGXBQRILfpbVizJKZF2XlVULyh
         UpsMJwDPUVP5O237kz/mdu56ipKqE20eZKNX1IQHlvB791p3wZvIPvSL78ythw/BsTrz
         rtvA==
X-Forwarded-Encrypted: i=1; AJvYcCUsXoc8aWYDzxQjDSw+S+/wTK9lX5jyHV/3PUI+kEAO4mmbo/WCsuZEQNJgGTRQ1RSFVcDGgg1lpVHDH25N2b4ybPi5gN49A/mlSwGt8Xi0l0W+hoxIFt4s4jCpAn8i4BAH/dKcbfKIj/3ESy9RT0A28urt3XW/WdELt9Av002jX5Dw4/xO
X-Gm-Message-State: AOJu0YwsFjtoeDjSgIScd4ed7cJx9EXS2/MdLPeCyJ82JMD/O2oEvZt4
	QmjTOXV9Ht6p9drXAkydlmnKDYEgPl8IKo7Wp4vRaR8dbd+0pDuuC+T6nGHS/Hj/nphEYpL2N4f
	NNUqdVnaK8mB1fopu643PLM6fhUA=
X-Google-Smtp-Source: AGHT+IF7MgqUj7NAYok7BIhuXjGbhI85Yb/h9+YNKq9JCA25YqjK4vUmRdjvJNQXIXwX80fcdNu+pXkNi4gpR5CYAtg=
X-Received: by 2002:a05:6402:e9a:b0:565:af1d:7416 with SMTP id
 h26-20020a0564020e9a00b00565af1d7416mr8007975eda.5.1709109735183; Wed, 28 Feb
 2024 00:42:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227175513.8703-1-pvkumar5749404@gmail.com> <Zd7lqr8Cz4XrNoI8@nanopsycho>
In-Reply-To: <Zd7lqr8Cz4XrNoI8@nanopsycho>
From: prabhav kumar <pvkumar5749404@gmail.com>
Date: Wed, 28 Feb 2024 14:12:01 +0530
Message-ID: <CAH8oh8U1KLxY95DQW9duU30VC5hdQd1YKs+8USuuz0k4JWtBSQ@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: net: Correct couple of spelling mistakes
To: Jiri Pirko <jiri@resnulli.us>
Cc: shuah@kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, petrm@nvidia.com, idosch@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 1:20=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Please fix the patch subject to include appropriate prefixes and
> rephrase a bit like this:
>
> Subject: [PATCH net-next] selftests: net: Correct couple of spelling mist=
akes
>
> pw-bot: cr
>
>
> Tue, Feb 27, 2024 at 06:55:13PM CET, pvkumar5749404@gmail.com wrote:
> >Changes :
> >       - "excercise" is corrected to "exercise" in drivers/net/mlxsw/spe=
ctrum-2/tc_flower.sh
> >       - "mutliple" is corrected to "multiple" in drivers/net/netdevsim/=
ethtool-fec.sh
> >
> >Signed-off-by: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
> >---
> > .../testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh | 2 +-
> > tools/testing/selftests/drivers/net/netdevsim/ethtool-fec.sh    | 2 +-
> > 2 files changed, 2 insertions(+), 2 deletions(-)
> >
> >diff --git a/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flo=
wer.sh b/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh
> >index 616d3581419c..31252bc8775e 100755
> >--- a/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh
> >+++ b/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh
> >@@ -869,7 +869,7 @@ bloom_simple_test()
> > bloom_complex_test()
> > {
> >       # Bloom filter index computation is affected from region ID, eRP
> >-      # ID and from the region key size. In order to excercise those pa=
rts
> >+      # ID and from the region key size. In order to exercise those par=
ts
> >       # of the Bloom filter code, use a series of regions, each with a
> >       # different key size and send packet that should hit all of them.
> >       local index
> >diff --git a/tools/testing/selftests/drivers/net/netdevsim/ethtool-fec.s=
h b/tools/testing/selftests/drivers/net/netdevsim/ethtool-fec.sh
> >index 7d7829f57550..6c52ce1b0450 100755
> >--- a/tools/testing/selftests/drivers/net/netdevsim/ethtool-fec.sh
> >+++ b/tools/testing/selftests/drivers/net/netdevsim/ethtool-fec.sh
> >@@ -49,7 +49,7 @@ for o in llrs rs; do
> > Active FEC encoding: ${o^^}"
> > done
> >
> >-# Test mutliple bits
> >+# Test multiple bits
> > $ETHTOOL --set-fec $NSIM_NETDEV encoding rs llrs
> > check $?
> > s=3D$($ETHTOOL --show-fec $NSIM_NETDEV | tail -2)
> >--
> >2.34.1
> >
> >

