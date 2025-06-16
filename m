Return-Path: <linux-kselftest+bounces-35060-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BEDADAE0D
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 13:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4DD17A46ED
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 11:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463AD2BCF72;
	Mon, 16 Jun 2025 11:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eh7+zDd0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F76298CDE;
	Mon, 16 Jun 2025 11:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750072250; cv=none; b=pUUVvfq4SMNs+y1JKLF2eHcYfw+oHCNP0JHPmcoWdcxcmmE4r3UlSCl2WsjU/GdiJwihqf1WtEpWOkOVinuOPMeZ6RGBG30AlEZdrKXsqRRo6iu5hsysGzgmQaYtPvkPWw5ED7+VtX8gpzPln5FvBfpsQ/8yi0XkXV/G6/3MbIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750072250; c=relaxed/simple;
	bh=xhcOPEUMGjq+mEH0FdaV1/7R5d+5ezqyb9EzkMGxhhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aE5Cx0D359CEY+38TGMIljxSXiR26zFmU7HiRmPX2V7yAk3YX8Rxj37r7n0e91FZdwG3PAAH+i2vj4qr9IxNxJ3XQYPRbKcp1RgmUOs8FFW8VHpEn5TxULqilMaZmOouRzfVfLSePETOBDy6m6szSD/1qCHd3qNJ0iacha8wmZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eh7+zDd0; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2db2f23f174so3094445fac.2;
        Mon, 16 Jun 2025 04:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750072248; x=1750677048; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9JOrikw19Evhiqc8UDDBD5xigLuiawjysCMTOyrgP6g=;
        b=eh7+zDd0qgJDKX9BO+dPFcmsao3KB+fvQ5ADUJExAF9zGrpMZMUGg5xdqckwbqxa8Z
         dHkFL4zkeQe6nHCQ6o00cdVG9SGZ2yRug9DbkLhADqDbfLCQmCTCIy6IUe92ct/eXUbr
         9QvR4BY4e2iyqGuRnEZ9GaBfOfdgFLeCYPgHEvT/qW5uGrVXa0udR3B1uLxFIfa8rBDt
         0HCkdIxMGIh70vvodUAhxKv/dkUwEk5uaVPhwoDgussxDK0IYFQaXePqf2mcJXKjiBvZ
         Pl0VbR3YEqaZm5mEAZap20GE3A1dvE0XzmjueD7rM/4tk5QTYc4xx4jxXlauBZ3oHBUc
         i+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750072248; x=1750677048;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9JOrikw19Evhiqc8UDDBD5xigLuiawjysCMTOyrgP6g=;
        b=E8+6AOEuUc2OCRXqaRfHyE0WvA5szD86mF2aGJLwYb1TvsytP9GXSgSMCIHdq8xWWu
         Mex+5JAymcCmf73L4NeVHows/HwyCQaOmqxAurZcFIEjfR6a3/ldZNnaw46uaFxDA6Yp
         VWIlNl445OlNX3lJjqDpZBrPwHgdO0D7NLpCIC77zAf3s/sIQiOWZgrdimQo3BzZ3oCf
         oZNq4V8Ig491R1vnrOIPP9N8+SCKPFt7L7wNtXhJim1OsNXsc+T7Bv3QdDgAJKUf6xnK
         1/NfGoXf8dsKeBzRqa199RD14a5QbAv1/jDucHD/BPobqtKAAQx32EtFJxecGpr+T0I7
         K2uw==
X-Forwarded-Encrypted: i=1; AJvYcCWgXzklqrcIAqocoetc31JZBocwZSHhh8+uXZybMHgbaUTcXD7Lt2UrvI50YTGAe98pdnv/7kLl@vger.kernel.org, AJvYcCWn5PbOU1fi7h9aw4Hc2olZCz2WY6m1iGw1oLc9Fzf0iF9B+8bauNnRzLxHccFxycZE3mJueCUmKz1eVLUljSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBJ8Jnw/9+us2QAEJ0iALsBHZI11KFHyricaSZf6ebTG4g+cpp
	UybTAq0Ap/m49bT4QgiG4ZBF0H4jsNdG35ZlkWxBobFNqLPuUdjeEuQjRfn9yFoWDWIIr2k6Kt8
	Z+YuwOOWHbnW7HTcFZ1tiuoIoeTme/y4=
X-Gm-Gg: ASbGncvZNy9s+MtFwvv3M3Ppnce0qtLHj7p14p7KhrQhqfBXtCfyplBzMSRcMmoqsDg
	2e36E4UUiPn7M/4mNQ8/hHPyARUox8Q4LIL3teDbpz6/6hQ89dH8j7xXZv+0Dfwln+QJWVfZM2U
	HBeGtls5UY8dRh23FZJ+YEd/U7ULHPQrMuLqP0T+uIeVAm95U9tA1O/Wrp+oQvlVP75RQR4Mx2L
	A==
X-Google-Smtp-Source: AGHT+IGblsALpcTnzDp+zkVZ/nft3tu8iBioL3Oz3LjdP2OgIaHJrxs0jz36iDATUTnwvRAhRVXBRlart+/5mAeYnac=
X-Received: by 2002:a05:6870:d393:b0:2d5:4b92:a787 with SMTP id
 586e51a60fabf-2eaf0a14c68mr4656287fac.18.1750072247640; Mon, 16 Jun 2025
 04:10:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250614160850.11087-1-chia-yu.chang@nokia-bell-labs.com> <20250614160850.11087-6-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250614160850.11087-6-chia-yu.chang@nokia-bell-labs.com>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Mon, 16 Jun 2025 12:10:35 +0100
X-Gm-Features: AX0GCFv8Py_NTaergTm8EtgFjKYQJPP8YyYG00spZrlUlc3e_Vh2Pu_cXk4O90Q
Message-ID: <CAD4GDZxQ_jNch0a71gwJUq4=fYQ963-0b=Xz1gwG5qmNdiQ82g@mail.gmail.com>
Subject: Re: [PATCH v19 net-next 5/5] Documentation: netlink: specs: tc: Add
 DualPI2 specification
To: chia-yu.chang@nokia-bell-labs.com
Cc: alok.a.tiwari@oracle.com, pctammela@mojatatu.com, horms@kernel.org, 
	xandfury@gmail.com, netdev@vger.kernel.org, dave.taht@gmail.com, 
	pabeni@redhat.com, jhs@mojatatu.com, kuba@kernel.org, 
	stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch, 
	ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com, 
	koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com, 
	ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com, 
	cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com, 
	vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 14 Jun 2025 at 17:09, <chia-yu.chang@nokia-bell-labs.com> wrote:
> +  -
> +    name: tc-dualpi2-attrs

I just noticed that this causes a double-prefixed name in
tools/net/ynl/generated/tc-user.h

struct tc_tc_dualpi2_attrs

It should just be dualpi2-attrs

> +    name-prefix: tca-dualpi2-
> +    attributes:
[...]
> @@ -3708,6 +3868,9 @@ sub-messages:
>        -
>          value: drr
>          attribute-set: drr-attrs
> +      -
> +        value: dualpi2
> +        attribute-set: tc-dualpi2-attrs

And here.

