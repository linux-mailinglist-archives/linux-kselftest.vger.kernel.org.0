Return-Path: <linux-kselftest+bounces-12005-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADDF9096AD
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 10:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1AC81C21FCB
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 08:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A06117BA5;
	Sat, 15 Jun 2024 08:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="XtIhAW0w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F7wLuAaJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D843E171B0;
	Sat, 15 Jun 2024 08:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718438564; cv=none; b=QIUkzbHTdDsYCDmi7WikGDkSni5Q8wbbdnq9Btx0sKC7NtciLyiM+yoGgsTyHJt8tpKuKKOb89UT9WYQq93VNZZICFjl7St6M857tXw7i00RtMuY34tXcmbkPyOySmofkAJ+TCsgCAZW7fk306qj8XvSEVmh/ITzVM7ri41unuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718438564; c=relaxed/simple;
	bh=QvARnw7AZhKjjQZEHPIbrdOAmJBynmSEuT5URqajrxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDqE2lkiD30d6jySHLCH/vyjUVqhH34HLt99179zrFm2aVJaT23lYpeuNlpVSXbzAuegWyfZfudK3G0l1rqEVhTllQPVjiAfc/pABfnDAxEDSrT+JkhTzFf/d7zouA3PZbf3cOY8Eiab++daW/1Xv+Rnq9M1U4AucKO8Rhk2+cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=XtIhAW0w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F7wLuAaJ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id C700213803BE;
	Sat, 15 Jun 2024 04:02:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 15 Jun 2024 04:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1718438560; x=
	1718524960; bh=D02etgLXt8LNRqfGRrozVpFaw8dGLSbYbhownIAXV0U=; b=X
	tIhAW0wLIoj+mTEQQrSbfwqNN0mJjJEEOH3VzM87ZPM/t/8TOGLGgDAdGbkntWS0
	OA4Am0u+u6KlKSUM1Ep0Np3So3Akwrco946q4+k7kUigsQO0DVdJH/vIfGez/bPK
	MsF+naIQBbNh87zT5ugQJhb1HCoFRISWUH65dxOr1BHocoPDuBH0ab7mmKgJiK0O
	0ivAUmQnI09kgV2Z9NEbOaYh2Yf6u+fLCODn49M5UFy2bezx5Oep8bq6h/6uyy3i
	9pLf9jhXEF/iPEo70clhq5tff9ljC/kb0MLYsF8pVPWCRe02RdZmlg4K9DRDA6Tx
	KtsvzAeL0B6dMaxWhJ7mQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718438560; x=1718524960; bh=D02etgLXt8LNRqfGRrozVpFaw8dG
	LSbYbhownIAXV0U=; b=F7wLuAaJPR/pKuyWJM+phWXmRI4VqNnkqlHCh/g9QKN1
	Hmn6fPqs+AZf/r9KJZFlRQgXkZ17yIWltGlwf57202kb9qxhinHF1/c4g090TqKQ
	j/vpbulA2AT0+X+b2dGE97l+EalSJQrdWEZp/QyqtdvzL6exb8lmh/DHstNbixp5
	ddgejDp6pN4r4YTs5+sqIh0GudPYMS4Q953z37lAqVSaqN/7FVBcv3N3AocBZakw
	WyrOjeZrMcFWnYQ/8b5j4xyLG/AlIbvTJhO6ws+8yxrnMLTsshgnvdPxiV1KvK81
	2FblP7PVqMG5Ppk4erkcyf2u8woISFJSZcAiqkwUFA==
X-ME-Sender: <xms:oEptZrGXyIcRnSj-CwuzSuOrLAfVaFDjSgSHcDwl7VuU4lH4wE3yfA>
    <xme:oEptZoW406XXBMLK_c0l5ucAaYgxrNAHf3N_oSTkmn-o9I4eUc9X_3hlnF_8TMzNE
    GvkD0sNDzPacJEsWZg>
X-ME-Received: <xmr:oEptZtJm6Towjaw4u14wmf96xz2jvqiJ_4TMMtGhaR12O-FHiJORmwgQmAvwoN5rJnWQDP0AK-gaJ3apqgpABj63KBWLwEs8tsM3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvtddguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghk
    rghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhih
    drjhhpqeenucggtffrrghtthgvrhhnpeehhffhteetgfekvdeiueffveevueeftdelhfej
    ieeitedvleeftdfgfeeuudekueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:oEptZpHfPPLAxm7D6fp5kwyMbHmsSACoOTCIGtmaU6kEltaRxTrivQ>
    <xmx:oEptZhU7t-gW96_uJ-sPZpbEssa3b4oyMgmi3KlgNNJa421JfoimWg>
    <xmx:oEptZkOiW-Nvb9jQF8uj9R1184K6VySOnqvHdqL9Usk4oLQ-iCE6-g>
    <xmx:oEptZg3aLURdUVVcVYlfV1Y3ZgTQ8i942hQWQFTnBn7Gy_f7EdaT5Q>
    <xmx:oEptZjJLv9LkoLzFCbrmTm5XIvi2SIsmX81yc5bpPs6KHb-GzR3vLoTb>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 15 Jun 2024 04:02:38 -0400 (EDT)
Date: Sat, 15 Jun 2024 17:02:35 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-sound@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 3/6] ALSA: control: Apply sanity check of input values
 for user elements
Message-ID: <20240615080235.GA508000@workstation.local>
References: <20240614153717.30143-1-tiwai@suse.de>
 <20240614153717.30143-4-tiwai@suse.de>
 <20240615051329.GA494527@workstation.local>
 <871q4y7jgt.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871q4y7jgt.wl-tiwai@suse.de>

On Sat, Jun 15, 2024 at 09:28:50AM +0200, Takashi Iwai wrote:
> > In the commit coment, I can see "that's the only way to filter out the
> > invalid values", however it not so good idea, since the ALSA control core
> > function loses transparency against control elements somehow.
> 
> Transparency?  The sanity check of input values is done in each driver
> side, hence some overhead is more or less always present, depending on
> the implementation.
>
> > Furthermore, I can see "there is no corresponding driver", however it is
> > suspicious somehow. It would be smart to charge the validation
> > implementation for user-defined control element set if forcing it.
> 
> The context there implies that, in the case of user elements, all
> handled in sound/core/control.c, and there is no other dedicated
> driver code handling the control put for those controls, hence
> sound/core/control.c is the only place where we can address the
> issue.

If you can force the validation to _all_ of the existing drivers by any
kind of mechanism, it would be. Actually, not. We can have such driver
which handles the write request without such validation, and control core
allows it. The kernel configuration is to ease the detection of such
drivers (and applications) in application runtime. Therefore the
transparency would be lost by the patch.

Assuming that two control element exist in a sound card, which has the
same information and TLV response, except for the flag of
SNDRV_CTL_ELEM_ACCESS_USER. For the same value data, one operation with
SNDRV_CTL_IOCTL_ELEM_WRITE is successful, and another operation with
SNDRV_CTL_ELEM_ACCESS_USER is failed. When encountering this issue,
the programmer of the application suspect the bug pertaining to the latter
control, then the programmer find the latter has
SNDRV_CTL_ELEM_ACCESS_USER. Then the programmer would judge that 'I got
it, it is a bug of user-defined control element set' even if the program
includes the bug for min/max/step computation and the underlying sound
driver includes the bug not to validate value data.

The patch loses transparency in the above step. Without the patch, both
operations finish with the equivalent result.


Nevertheless, I think the validation is itself preferable. In my opinion,
the validation before/after the call of 'snd_kcontrol_put_t' would result
in the different argument. The 'validate-before-call' is the argument of
control core function, while 'validate-after-call is the argument of
implementation of user-defined element set. The patch should belong to the
latter to extend current implementation of user-defined element set.
Thus I suggest to put the validation into the put callback function,
regardless of the optimization to which you address.


Regards

Takashi Sakamoto

