Return-Path: <linux-kselftest+bounces-12483-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C90912F80
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 23:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E16511C20A1A
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 21:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC77216DED5;
	Fri, 21 Jun 2024 21:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PLC/wd+X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D57F4A3F
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Jun 2024 21:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719005162; cv=none; b=byaFlROGG0IYUw7NJat3gC4PTt63RZK+PPcnBcbO04hVRpg6xWCjftjIVxu8ejIoeA+/SUy6aP86Wk09P/vL68J052li5ci0bdyx2MFNIhah8dFMeWVif/hjs/zdN+G0TYGfjFhNY47UKRQzlXWZPvwG4jZ1093H9JADMgZabHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719005162; c=relaxed/simple;
	bh=YDYCA8wJOBA3X8vhr3CVeTIV+J8Ha3LSgJFg76UCzXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0sqjaQJ6uKqRA+bNcTfqIUzN3bs3o1GQpvX6a+dTh1mA8f7L41OMvvRK0vJA24H5s13QKq2vyyy/gCeNUslonUEYKiJekQ3KFIzUNG/CUR6ezKS0RX9TJ13qHfAB2fw+YtEfnYgFtUITzOU1uFo8bWkeFuhW149E2o4dAgk6KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PLC/wd+X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719005160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u/T8Pvz9LshbiBtj6Z7y3S1f+nrkLBzQalMGcdL981Y=;
	b=PLC/wd+XLbH4Ji4dplFxzpmJGCvWm9Jyk2/m5vpin4vxADvDZ8w9SMBUQaINRX8gBTROaB
	ZJvhU/4c5Kegu0jlADmWRkdzqwBmbfmjAysNb2xNUTsBKFgNks0l2pgOJwUv9Rr/Vu3F1/
	cO8r4HNnXNmd5d43brW4hKmcDoBnle4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-blA5jd2bNvqTIhm0tHkevA-1; Fri, 21 Jun 2024 17:25:59 -0400
X-MC-Unique: blA5jd2bNvqTIhm0tHkevA-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4401522c6bdso4966101cf.3
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Jun 2024 14:25:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719005158; x=1719609958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/T8Pvz9LshbiBtj6Z7y3S1f+nrkLBzQalMGcdL981Y=;
        b=GXj9B3s2SbhyK7FmeqesnHqxhyZXikd6AEr/3ryH7X2MwpKIfYmLc7iKUmQVXHlOKd
         RCZcr3YM1faqqPWWEyDqEN1/tPsDRyFag2ogSto7+VfhpFovwz8AsZydtwwH/BgaEpn+
         5bgirHjw8TFh1jrryGOIcNKz/UKHpeA/wMe3ue+ixJZ+M3B+hIdf9cI5qb3ji4RsyFrE
         Smy7s3mWb8IAKCjIxQaMTsbrFNyc6Rh/g2AAl9yrSLBUnC0h7fUFswqrC7uo0jHhLXmp
         pyYCoA9LkzVvCG3GgZbCqRa2tqvts109mUw77ESYv5iCsz2s1O7B/8S3UVCxbuZ6w7GN
         kbhg==
X-Forwarded-Encrypted: i=1; AJvYcCXZAk8CaslAOfRMwu8oLuusOXKHPT512uLPlxjipGHnEm5oYL0Ix4T9/r3NI1tEpJW4wVhWnhgU8jp8fxxdr5RFZbdoyOo+GqJ5+xKTZOD+
X-Gm-Message-State: AOJu0YwQcPXAT8VPNFiBWtlBd183TnD+6IV91RNj04cRrK/U9AAI5jtG
	m6+pZ6xZ96s3jw1u8YLlYAMcjse1QqE1Tm0miSKbmtYqKiOYZrnsTqYWxWPktfPAaAG5Aw6MphL
	V1e6tNiHHfgxUXmWAYNQd8RCFsr8TG/nLismoj/sBHTfmY/cqdRC/Mn4AjaLK5qlfBw==
X-Received: by 2002:a05:6214:529a:b0:6b0:6a38:e01d with SMTP id 6a1803df08f44-6b52fc416dfmr680686d6.0.1719005158441;
        Fri, 21 Jun 2024 14:25:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaMaAMcHEU0045p1ZpCQKXUo66j+A2d+/nXH5cYrtdn67byrEdkgmV5fsdBs5DMdo8eDr18A==
X-Received: by 2002:a05:6214:529a:b0:6b0:6a38:e01d with SMTP id 6a1803df08f44-6b52fc416dfmr680436d6.0.1719005157881;
        Fri, 21 Jun 2024 14:25:57 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ed181fcsm12172526d6.39.2024.06.21.14.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 14:25:57 -0700 (PDT)
Date: Fri, 21 Jun 2024 17:25:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Audra Mitchell <audra@redhat.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	aarcange@redhat.com, akpm@linux-foundation.org,
	rppt@linux.vnet.ibm.com, shli@fb.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, raquini@redhat.com
Subject: Re: [PATCH v2 1/3] Fix userfaultfd_api to return EINVAL as expected
Message-ID: <ZnXv4rsk11KLS1xF@x1n>
References: <20240621181224.3881179-1-audra@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240621181224.3881179-1-audra@redhat.com>

On Fri, Jun 21, 2024 at 02:12:22PM -0400, Audra Mitchell wrote:
> Currently if we request a feature that is not set in the Kernel
> config we fail silently and return all the available features. However,
> the man page indicates we should return an EINVAL.
> 
> We need to fix this issue since we can end up with a Kernel warning
> should a program request the feature UFFD_FEATURE_WP_UNPOPULATED on
> a kernel with the config not set with this feature.
> 
>  [  200.812896] WARNING: CPU: 91 PID: 13634 at mm/memory.c:1660 zap_pte_range+0x43d/0x660
>  [  200.820738] Modules linked in:
>  [  200.869387] CPU: 91 PID: 13634 Comm: userfaultfd Kdump: loaded Not tainted 6.9.0-rc5+ #8
>  [  200.877477] Hardware name: Dell Inc. PowerEdge R6525/0N7YGH, BIOS 2.7.3 03/30/2022
>  [  200.885052] RIP: 0010:zap_pte_range+0x43d/0x660
> 
> Fixes: e06f1e1dd499 ("userfaultfd: wp: enabled write protection in userfaultfd API")
> Signed-off-by: Audra Mitchell <audra@redhat.com>

Please prefix the subject with "mm/uffd:" or "mm/userfault:" if there's a
repost.

Acked-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu


