Return-Path: <linux-kselftest+bounces-3315-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A51A08363C3
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 13:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0BE61C24236
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 12:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4718E3BB52;
	Mon, 22 Jan 2024 12:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SQl/V1bc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE743BB22
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Jan 2024 12:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705928116; cv=none; b=c6Mg+qy3fWK2NYgW4hmFq92rVQ8JoIuswWxGhWZ+mQ3NpwHw5KuBXgzQ8JLDx879jI9A6OcDB1vTfyn4fpkBADXzwJpDabkJwinRjGNQkX5i6TsqVTfXXxBxwsCfM0v9EXuHv87COzXsS384xpnEqq+ndW2daiXQedAeu/eYGnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705928116; c=relaxed/simple;
	bh=v+L7PVTpZDw0rKx6LNXPOAvhzXFGb5VQm0BCqFUAkRQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R16pkjFffedPcUxsZgRWMX6NnKHRTKDAr36Oikp2RoTwhhD06mZZeEng/bHsAhjR00stuEs81UNpLRmru8XzkZAA1tp5k4ZAhtGVkyP63doHTFPVrNyhfpxqoqtVSqC/HbOVXg3q0pqrSrz8heLIE2xKqdaUQrOSiepHmDkn2jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SQl/V1bc; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-559cef15db5so7396718a12.0
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Jan 2024 04:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1705928112; x=1706532912; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IuUKVWtvvYIXVeVdCt3DqjuZg1hGyra7osExMMOSS2E=;
        b=SQl/V1bcIuhJ5oVnf9KbTKasKw/Xc9CFzbh4SxN5CjzJDNDyaaY7llm9PPRgzR6u9F
         OHV9I+5WhAMPolI5Ks8oBWlKTDa8gjb7M9JjQ2GD5/j8+Q02z0QUpLTae3EtL0rR60Ni
         uRxndjWKzk+5iv8yzMlciuJ7hLrbKp3P8Mn2Eif7I1Dok5xbHJ4YDIywdyWj87n1TKJb
         EqiGacj03JUOdgJlBgTbfxnH2qNueapOZqAM1eEL60M8r250R94FwiwsdvrTqr9XPJiI
         pHTO8Nz8MvAl2F+2jxO4C2VJW0A7tQ/Hm/2hZOoXgkmrkw0Uu8xpRCbbT+uVHSKx7xyq
         szVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705928112; x=1706532912;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IuUKVWtvvYIXVeVdCt3DqjuZg1hGyra7osExMMOSS2E=;
        b=j7PqHS3BNkseI7feDb8wZS3ZTNSN8Q2kkkm5ORA7eLC+a2asHR9SUgaTS5RU9I2koc
         0r93Xx01DjT67bBVYfnmJThDjNr2aLdpIk/kSVD3j5A2I8rpTUy8AgZkE/UzoQD5EmTo
         aMM4YX4jpasV4+mMg93X5wAq00z+c2eWK5r53ggPxMgAUdX+Ahlwxs5iRwOnZDOBvyDj
         Mrw1DtQbcWxJe8W3KKBUfLqa8MMvbUNjixS+iqVE4xv2vtXXGKmTRGpQ0ROKCrsg2o85
         LSOm9dD4yxhtyDLDL7nfBvQAZ5dAQOfa68SHoL2+Y4yADbabzIE3wfVBGil0AeIxPFKa
         /V3w==
X-Gm-Message-State: AOJu0YzN0cWtxqhOH31c9BAyWwUFs5Mq6GX7vpS0o8eB/dnWkgB2t3Am
	OZtSe9FsAROizbWuhwl0OlfrmnTwk0fuJA1uUuB2BqKdr4eqD96BYaT3HYxnryA=
X-Google-Smtp-Source: AGHT+IFMwp2rvA2TkeKR8EEYT9ihnqdp0q0BkNQSHFUaT5nh8UK+VHg2raGKecMA0Ym1+fdVY83xQA==
X-Received: by 2002:a17:907:778c:b0:a2f:6053:2ab7 with SMTP id ky12-20020a170907778c00b00a2f60532ab7mr5368477ejc.11.1705928112494;
        Mon, 22 Jan 2024 04:55:12 -0800 (PST)
Received: from ?IPv6:2804:30c:974:ac00:1b02:e2fd:23be:79bc? ([2804:30c:974:ac00:1b02:e2fd:23be:79bc])
        by smtp.gmail.com with ESMTPSA id g10-20020a92cdaa000000b00361b87d1645sm1526721ild.54.2024.01.22.04.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 04:55:12 -0800 (PST)
Message-ID: <53cf93b2efadc0f42712eb92436bd575b5622664.camel@suse.com>
Subject: Re: [PATCH v6 2/3] livepatch: Move tests from lib/livepatch to
 selftests/livepatch
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina
 <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,  Petr Mladek
 <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 linux-kselftest@vger.kernel.org,  linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-s390@vger.kernel.org,
 live-patching@vger.kernel.org
Date: Mon, 22 Jan 2024 09:55:06 -0300
In-Reply-To: <Zap26MINbbxREt4c@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20240112-send-lp-kselftests-v6-0-79f3e9a46717@suse.com>
	 <20240112-send-lp-kselftests-v6-2-79f3e9a46717@suse.com>
	 <Zap04ddls7ZvbL/U@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
	 <Zap26MINbbxREt4c@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-01-19 at 14:19 +0100, Alexander Gordeev wrote:
> On Fri, Jan 19, 2024 at 02:11:01PM +0100, Alexander Gordeev wrote:
> > FWIW, for s390 part:
> >=20
> > Alexander Gordeev <agordeev@linux.ibm.com>
>=20
> Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>

Thanks Alexandre and Joe for testing and supporting the change.

Shuah, now that the issue found by that Joe was fixed, do you think the
change is ready to be merged? The patches were reviewed by three
different people already, and I don't know what else can be missing at
this point.

Thanks,
  Marcos



