Return-Path: <linux-kselftest+bounces-10197-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 513088C5CBA
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 23:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F461C2170E
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 21:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3248E181B93;
	Tue, 14 May 2024 21:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4dVJGaV6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B41417F36E
	for <linux-kselftest@vger.kernel.org>; Tue, 14 May 2024 21:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715721664; cv=none; b=BQTezPYqU3WerSjWBXuTW0AndcaiJESxWYSJkcai5u19IHZopCoN5li6NVr2uhKUs+KnMytz09Qq6fwbQ88H5E1aS6pG2YpYGFQyXLqtSeYk5k8RPDcabepHruSmx/7urG08t+qkoz0nrnOP2+Ds2XjReN67myolFOXIJ3JN8ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715721664; c=relaxed/simple;
	bh=CwPBPu20Q373SE94/2W5Gs5lJ3zjrSanPFx9uYehg0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgqiPS+CfVU1pc37Y0xiHwtcsHVEl6dSz8pmfxR1PE+Kmck5CKuQCOp8Ws2kBlLCvKORpuJKqHfJGTLr2h+RAWwlpMq2jiRpz3Zlt7bmcRSK7ylBmz0mNK2wmsO2oOEdD3muYV2n5Bu6QeCMlB+6qVKwjw7P516/V8usFtex6Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4dVJGaV6; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42012c85e61so211555e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 14 May 2024 14:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715721661; x=1716326461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CwPBPu20Q373SE94/2W5Gs5lJ3zjrSanPFx9uYehg0M=;
        b=4dVJGaV6gbT/74k+v2vX01UiSQm5+J3cdbUp13Ajx0HY0QhCG10FRaeB59efSxCcJ1
         ChieX2dM1//AptnKX2SoKrrwFi3SEGKNX9MSsqenII5v0oOa620JgsQUXoDmcuiyQnXy
         hr1Rl2+sLGwGG2wEQR6DO08/KWVlowi/1Zbp0Qg8hzBGNfc4sTGGeFfJfdvW3L2XxRoR
         j14DfxP24Ef7V5us8d76+nvzFUQdfN6ujqkeACuyTMgmKh7EelBZhgdCw8Co+2YkN9Wu
         V7PpdbLVNRxjKXFyT/Xl5vcgOzDTYO8adtyi/p2vG1KEYOQiJWV/Mq5VemKkz4XRi9YH
         /cdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715721661; x=1716326461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CwPBPu20Q373SE94/2W5Gs5lJ3zjrSanPFx9uYehg0M=;
        b=mppBjKueW9MYX0CT2CIkTd3YuJKaNgC+Val477b7wXMCLoWvyMsOcamEdno5V9oqrG
         jumUmSm7MMlmJjtShy9YBy+MCfqWDnBHeQxZhLrfAni7xEVZr58Jy9p179u9pdUiY+QV
         MIRR3eglDf5RzIUTaaGQpb9KJ+mwz7W7XV+GiqC8uDy+h/fE0pZ6GyuvILVEFTzSwM0k
         B6tYli78XboZwUt63ULxCXRS8oq4wMGsdiQ2CQogOuZwst2iwa/jiV9h3jSAApgzTQJW
         5tD2xhs6c+ddCDhOUKDiRZsaOTglqPCgIwzyp2zhJJ+PDBU71P0IF9n87k07Z5PfY79G
         hBjg==
X-Gm-Message-State: AOJu0Yyp2WkYQPDoZOGHC4NOfhMYcZzA9rSCVBz3m2kWw6m9pq9KvWFM
	F4VRhIwtzNnNs7yonswDNf1Qzf7AaM8sYXg+OYhtIsQK9vIWIRF2tiLKEI5PTA==
X-Google-Smtp-Source: AGHT+IFK25M0wgeXLfHIqwddgM4kRtbQlKmkMGa4V1C30HfAGSGO4wDqOPGaTUCXpXxxKks9YftHWQ==
X-Received: by 2002:a05:600c:1e12:b0:419:b16:9c14 with SMTP id 5b1f17b1804b1-4200f8697eemr7227225e9.1.1715721660799;
        Tue, 14 May 2024 14:21:00 -0700 (PDT)
Received: from google.com (49.222.77.34.bc.googleusercontent.com. [34.77.222.49])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fd491c712sm117556485e9.0.2024.05.14.14.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 14:21:00 -0700 (PDT)
Date: Tue, 14 May 2024 21:20:55 +0000
From: Brendan Jackman <jackmanb@google.com>
To: Daniel Latypov <dlatypov@google.com>, corbet@lwn.net
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>, davidgow@google.com,
	rmoar@google.com, corbet@lwn.net
Subject: Re: [PATCH v2] Documentation: kunit: Clarify test filter format
Message-ID: <ZkPVt9wyu7f-fC3c@google.com>
References: <20240402125109.1251232-1-jackmanb@google.com>
 <CAGS_qxpBmmafnQnDXYf5RftPzxghd+i8Ly4CK=EkcpidpCPP6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGS_qxpBmmafnQnDXYf5RftPzxghd+i8Ly4CK=EkcpidpCPP6g@mail.gmail.com>

On Wed, Apr 03, 2024 at 02:59:43PM -0700, Daniel Latypov wrote:
> Reviewed-by: Daniel Latypov <dlatypov@google.com>

Hi Jonathan, I think this is ready to be applied?

Thanks,
Brendan

