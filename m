Return-Path: <linux-kselftest+bounces-29047-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8ADA612A6
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 14:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 220091B63589
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 13:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401E91FF614;
	Fri, 14 Mar 2025 13:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NvXk6MiX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CB71FF60C
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 13:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741958986; cv=none; b=f9v52hYOJqYxuGn4zTXeRF68lKUIC/zBz9xqE0BgKnv4VB5dvDkGh13gHpQ+AfHSdl6FiwtO5NgSKVmFnfI8t6BTZWjUn/Z48kkz9WgPTcnWTRE1mjAdf7HqHvWF/DgSe1+2n4sV9CUm4Ag4ZPLWF3d8CRgNxUmeY+EC7ing9lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741958986; c=relaxed/simple;
	bh=0tSLTf9xsT/SWhyWGaL58IsV9Nm6rD84h8VdR1BZo7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIR78pNQFslPV+CsXAiQPMI3CqsrBw/xjd4G0D8ksoTGu+pR/q9O3AAYPCvdCE/pd5EUuxcMcgEtadOuQNXiryxj/gXPztfQXl86G8dr1/H5yGTc9pL6Z56Rau+9l9gIMlT7FNkFAYFEYeaWaKsHJRCOEtM2OTPNe3Qun2jPYn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NvXk6MiX; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cfe574976so13447065e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 06:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741958982; x=1742563782; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tP+uNOM98k8NKXIW+A2NCgIQkFQBDqZRXpFtfAXJS4U=;
        b=NvXk6MiX8TTVqkk7bH40KwyfqriHag2etSFXw66CuxA3uVGf0q8TordjVjQg3KflmE
         m/CoK1AAAQ8Q8KPhbTvIOz5+kNFK5UetA5sHyxVrmJ5rywH2wDzKFW8y36Lke0PTS8EZ
         6er7dZE9gQmDZx1Sd5XtIX4VClDveG11mhRmW6mC4+zVtXlN2HLfX4AwiRup5/CwIP67
         9PmLtoSICgjR0D7q3b2WGwG2IKlDAX8xX0E/vIWDg0TrHr4pq0lV9T7XIO3miBM5c2ob
         u5mT1tpskAVW61FmouOaBFtAXBsdDd2NgHYeMX2bH/XJfYL5r+dJsoK1wyvSYUSGC5xN
         6HLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741958982; x=1742563782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tP+uNOM98k8NKXIW+A2NCgIQkFQBDqZRXpFtfAXJS4U=;
        b=AyoS4TPPGhAMKU2v6dt6Nb4GBw3LC3HVRhDrQE+HDmhs4bCvxCX4+5pJ1NmZWttyz0
         vfpqlH7428+kefPoMai0si5wlwA0fi8bG1VD5LkbG4Ws0ROds1fyh0NqWS9XYEgZd7iT
         xXGwZdyzNgZb4M8IR/iG6klHtVqgNhWGr+rOT0VspklMYVucCbrBo4IGxGdkRhB8BL5J
         CbrZAUA/izRyaCmtX5cxugnSOfzDC0yOKoNkIcypRBRIGtQi6TZ/ruFkHgFthLCFsJJ8
         75Y2iD0xUHpXp4GVPEPGh+DmJRExrZzR2V0R2yG79S+eTPtSvv4u74bvNhVt2zHm1BfA
         icRg==
X-Forwarded-Encrypted: i=1; AJvYcCUZlEP3ucExhngUPu4h1YjN1Z+W8YUXzqzwr/8TvoVZNI2njZyf72IN9hbdKBYQUtg3EFqIHIm1DFKy+6hqFG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcOyX3YiBPfdftpmAGy+y1g5RZ412vS7JkZFMZ4Kjcg/Q4aGUf
	P7SfDg8W3+zPp2is6d7W224ACydw/3H9UPhyCv+luGSGe3DnQufIxCf7hqb3Wv8=
X-Gm-Gg: ASbGncv/D+ytGcg58iHMEBgp0uiWHZzgmandX1edMmWY0nQOyjjRq1/w4Cx3U2BO5Ku
	CN0Ag3xrdO8YOpyjt8vpfOqyE1AIq6SFnK2xnl76E6N60Lpsl9ll5tM81Cr8QYvznfwFV2LJdNI
	aLuCWpRgslqfbx967pz6wBMbN4uWhudAMPiuksgdcZkhuQ/c+vBdHnJJefdAsERNPz3CxeEMaKf
	Zojp7F9QckYsT3qGsBhl+J+GJpWzhUQBm//unUb8aeP/NqaW8RFlQ9hbn/gyMPZiUvgYCGLxUhW
	6Z2Bna5/6hAwQ5XDtoG+CuWvi9OtoyU4ch1wx4mTPrVmtBieF275Ipa7yA==
X-Google-Smtp-Source: AGHT+IE38fHIEK56uEl/05JrmiS2ZMg7KADfrV25AuJoLIUtmBYrJdxZ9Tyj3UaE9TpYVp270vbvEQ==
X-Received: by 2002:a05:600c:26d4:b0:43c:fd1b:d6d6 with SMTP id 5b1f17b1804b1-43d1f60a4f1mr28413685e9.31.1741958982465;
        Fri, 14 Mar 2025 06:29:42 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d2010e618sm17677555e9.40.2025.03.14.06.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 06:29:41 -0700 (PDT)
Date: Fri, 14 Mar 2025 14:29:40 +0100
From: Petr Mladek <pmladek@suse.com>
To: Tamir Duberstein <tamird@gmail.com>, Kees Cook <kees@kernel.org>
Cc: David Gow <davidgow@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v9 0/6] scanf: convert self-test to KUnit
Message-ID: <Z9QvRJE0Yun5mfsN@pathway.suse.cz>
References: <20250307-scanf-kunit-convert-v9-0-b98820fa39ff@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307-scanf-kunit-convert-v9-0-b98820fa39ff@gmail.com>

On Fri 2025-03-07 06:27:33, Tamir Duberstein wrote:
> This is one of just 3 remaining "Test Module" kselftests (the others
> being bitmap and printf), the rest having been converted to KUnit. In
> addition to the enclosed patch, please consider this an RFC on the
> removal of the "Test Module" kselftest machinery.
> 
> Tamir Duberstein (6):
>       scanf: implicate test line in failure messages
>       scanf: remove redundant debug logs
>       scanf: convert self-test to KUnit
>       scanf: break kunit into test cases

Kees, could you please take the above 5 patches as well
via the tree moving the KUNIT tests to lib/tests ?

They seem to be ready for linux-next and the next merge window.

>       scanf: tidy header `#include`s

This one is a bit controversial and might be added later.

>       scanf: further break kunit into test cases

This one was just an attempt. But I personally think that
it is not worth it.

Best Regards,
Petr

