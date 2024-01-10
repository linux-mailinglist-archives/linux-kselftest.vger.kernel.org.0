Return-Path: <linux-kselftest+bounces-2783-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94380829156
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 01:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D26B1F2630E
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 00:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F5C391;
	Wed, 10 Jan 2024 00:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="I27gy5NA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002D1ECF
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Jan 2024 00:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2cd053d5683so42303531fa.2
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Jan 2024 16:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1704846462; x=1705451262; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dyyk71hEnUH8o+yU27Ica0B5hnuq4HgZWd0sqVp36iI=;
        b=I27gy5NAkrwS27o+UFWt4GiitEODjtHGgLvpf5U4To5GiFyiag8m/bFDjvClWkwzUq
         tkbpI//Z2DDD0YMaktuC8E6fzZ2ibJ2XIcNqui5IU9DuQkR74seal/wjXaSEyUiVfCHR
         PZCVydIffLiZGP3je/p+l9UhBSSIBcN+3MfwBydtCIk3NlPcF+WPu5sEBkkgT8PNJ6Pi
         mkmTjxCEPZSzAkMZjO4LMktJpeYcZSor5h6QW3WAlYlnA+rCPBm6X8Q4uP/Ata0M1wFE
         wAIhfaizSzyrkWEjfmLqUvg/6LlSuDQeiD3bsxYIlTpr4Ra3J/AEysl9Ms9V05takTqQ
         ravg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704846462; x=1705451262;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dyyk71hEnUH8o+yU27Ica0B5hnuq4HgZWd0sqVp36iI=;
        b=GtZc0dabDQ7egg/6NPaMBsAcjO4sXJhIPXAtOIWfZ/lp+bc7oZxyFKi+x4wY+4CnCg
         W1e3uDxli2MAusjfB22EQ5L3zzbIVA5Tnynw5qDYqspNe/kfY1oRG5bYyBjscxJpnuO3
         MZIVJTuXTy5hJx3hcaqSz/sXhCbHO1D9xw36GyaPVlc5zgn6hZOicDWl61Hna5h19/0y
         lmM81YxZY/rpq/IItf1up77nfgvrevgIzFv1lzJo2VgjS0ogbSRB9dIWstEjfuOmJX15
         Nb8Vv34wFigeO68haswnq45dgISo6nSBxW4gRnMZBu3TrvW/UTjoyfsKkvmxAlUvkayB
         Yjcw==
X-Gm-Message-State: AOJu0YxwwdrsZoGjDhyAasfeIyhDXDpecDZovcFtSmMz7CEleceRqHLw
	ukrRhsvQzflf+L2W4DEnQcCeZC3aKyi31A==
X-Google-Smtp-Source: AGHT+IHrPfMyoRcp9SJQJNfwgTAOMS35Hg1hTDLX2tyHfdnWr4LZ1cgREPzxpiaVrsGwmdO64/AgPA==
X-Received: by 2002:a2e:98d3:0:b0:2cd:433:bdfc with SMTP id s19-20020a2e98d3000000b002cd0433bdfcmr88914ljj.5.1704846461991;
        Tue, 09 Jan 2024 16:27:41 -0800 (PST)
Received: from ?IPv6:2804:30c:1668:b300:8fcd:588d:fb77:ed04? ([2804:30c:1668:b300:8fcd:588d:fb77:ed04])
        by smtp.gmail.com with ESMTPSA id bw10-20020a056638460a00b0046e33773c09sm940129jab.36.2024.01.09.16.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 16:27:41 -0800 (PST)
Message-ID: <79e4f9c604a8e2a9165a84473a7c5354dd11c2db.camel@suse.com>
Subject: Re: [PATCH RESEND v4 1/3] kselftests: lib.mk: Add TEST_GEN_MODS_DIR
 variable
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Shuah Khan <skhan@linuxfoundation.org>, Joe Lawrence
	 <joe.lawrence@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>,  Sven Schnelle <svens@linux.ibm.com>, Josh
 Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,  Miroslav
 Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
 live-patching@vger.kernel.org
Date: Tue, 09 Jan 2024 21:27:34 -0300
In-Reply-To: <87b55a25-4288-4add-b2b3-0038ed41b08e@linuxfoundation.org>
References: <20231220-send-lp-kselftests-v4-0-3458ec1b1a38@suse.com>
	 <20231220-send-lp-kselftests-v4-1-3458ec1b1a38@suse.com>
	 <ZZSOtsbzpy2mvmUC@redhat.com>
	 <4fb169fd-393c-441e-b0f7-32a3777c1d11@linuxfoundation.org>
	 <11c112df801008f6bc4b7813645d505388894e29.camel@suse.com>
	 <87b55a25-4288-4add-b2b3-0038ed41b08e@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-01-09 at 12:31 -0700, Shuah Khan wrote:
> On 1/8/24 10:13, Marcos Paulo de Souza wrote:
> > On Wed, 2024-01-03 at 15:09 -0700, Shuah Khan wrote:
>=20
> > >=20
> > > Copying source files and object files doesn't sound right. This
> > > isn't
> > > how the ksleftest installs work. Let's fix this.
> >=20
> > Hi Shuah,
> >=20
> > what do you think about the proposed solution? Could you please
> > amend
> > the fix into the first patch if you think it's the right approach?
> >=20
>=20
> I would like to see a new revision of the patch series with the fix
> to
> the problem. I will pull this into a separate test branch for us all
> to test different scenarios. I would like to make sure the repo will
> stay clean after install in the case of when out of tree builds.
>=20
> Sorry I can't amend the patch as this isn't a trivial merge change.
> This change requires more testing.

I sent a v5 of the patches. This new version has that diff that I sent
earlier to avoid copying the Kbuild files. It worked on make install
and with gen_tar.

Feel free to use this version in your test branch then.

Thanks in advance,
  Marcos

>=20
> thanks,
> -- Shuah
>=20
>=20
>=20


