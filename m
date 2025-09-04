Return-Path: <linux-kselftest+bounces-40793-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B916B443EC
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 19:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27F7F1CC07F5
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 17:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534352D47EB;
	Thu,  4 Sep 2025 17:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YAs9TejA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B9821B905
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Sep 2025 17:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757005742; cv=none; b=uEHZaJIP1rogkVZq/UDmLD8BTte10jAU54Qe32+Ub69gSSBA6e6g9zl0MMxtn1ldD69z3b5VrHuI+K1Wh/lNFUTLlfcT/+6ZQaIkrJIZZE8Cy6iC+73BdvDNrbJYXy4SEqwzuig2V5OxhjEq79M0AE0mh8Sudqsre3Vb1QSgBKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757005742; c=relaxed/simple;
	bh=rtVoiEqArhk6jdIIAM0VXZHs2vMtXnbobPVPXnd96Ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QtViax1w3iMFTynai1RAetnvU2B6w5RW0+o13kSYOflUpFHe7Cw45gh/fMTVfMQSVtMj+OyHtFH9nNJbKfwv0azqEMBfH2tesZ7cGAb1pgShVkyHkSLwoyxCwHTRKKynmmn36VJMdGoshLxlmoymMEhcKEqrR2rwCLn6X7MZ9SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YAs9TejA; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61cfbb21fd1so747a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Sep 2025 10:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757005739; x=1757610539; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9l+BX4BeciP06MlQ3YhBfi/kk7JAIUUCElY1RG7/WT4=;
        b=YAs9TejA4b4mW7lVC9ebOHUPc/lOxXuZdTCq7mi3GS93GIGAeGLiE/uc2DHbpFr5bC
         CNyBETR3rxTLUO3Gk7POXXkpJA53uJnmXxb9dG0/aP4O2iGCXZ08eG63MU1RQ2hCZITU
         de9OJcHSCZGtoY9uh7+lMQvg2Ocu7avUJg+mmpshVpYzOA4OSnIZNrTOXBWQGJvGSigJ
         svm+m5/LxTOQlpgii4zQ86HyZjrrfginkOj+UN00yoaio3l0QkZTguThj2TaTctY0E2w
         xs3RZkKttQ0ZJ0DRuz0g4h+ro+mUzfkznU4CyDm4U+KHKi8icbIAYPBmEGW9rx8VcTxS
         B7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757005739; x=1757610539;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9l+BX4BeciP06MlQ3YhBfi/kk7JAIUUCElY1RG7/WT4=;
        b=fsP4gVjxnCBqo2deXT3fwh8vw8AYfs2Ut61UY3QmptAIiD2O/2rZMegQwTatPsSXld
         GPXmN3BahO6e23wdkN+DOFmJBT6QwMnLOZFOWpSFA50zB7AF3KaJRYRU2GRB4J11hfw9
         41dq6a7CheL6FCTuusgg0QW2tpVYC7xw/bcEeaWhnvtsWg7vAfA5KaTq73VSqYIZ1C7d
         KyzhYRjXJa1z9M3peCwHVSQrCPbQaK4pgiYqXnCQWiw1+aUsdeaD+xV1k3XJ4D+VRLnf
         bZFoz9MjiNj5Hy9H/fgG8JU81jLoeAmWl2ocTske+Ska8SuBmPQZnme0c+79QbInLJdS
         f1zw==
X-Forwarded-Encrypted: i=1; AJvYcCVPFlW0tOGZTQdLWyImqoJwWoAon+1dnFCk2Tr6qWvMw3zQ2uUCtsh9+dvYBvwKvDOiu2ojpt+zdFF32WEGnFI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1KgNWtea4o7k0ZMMqz7J1m58x3O1IOS37QzbkxZvM53lcW/H6
	g89/Z3kDVHan+DXHhaw2H8iDydwtyuEOqxyNLtaDLOL1LNvmcHu4ivfDXhxkry2gEVnBBqtNJJt
	o1mFh/e/t0vpops94ARLqg4nXF8Ki/tLqoX8t+Mt1
X-Gm-Gg: ASbGncuA8bYtYEmpZkCebXs2WOXNC1PViTxj9IUVV6282AaxbYraIJiuAQ88qMVrMsO
	mVru1kfz7xkXqGKm84chXVoaF6iX4MEdALro5CDPptCYzAwZ/ZP186QFB58/+4E7UDo3yKhDnFN
	bjFCueksx259zSAhE07Fu9sGZjRu2/2SQVFlytxfan0xKelfTdrX8DKf7SPYpqaOREuxHuehQye
	uFEwyZx+q1WBBfRc9bBrUceJQBXcukh+6XQE5SZ2Rn7AOu17S3ANay1kr/zT+fGzBgYiIwuxRcW
X-Google-Smtp-Source: AGHT+IF2ruMQe+WqyRmQ/okwctanAc23wDnLh4q8x7OzuSo6MwWq8CGCK4IZ++J24eerKVtO/lIr742TQbMqgGEV01E=
X-Received: by 2002:a50:934f:0:b0:61c:c9e3:18f9 with SMTP id
 4fb4d7f45d1cf-61f5bd290c7mr71874a12.3.1757005738679; Thu, 04 Sep 2025
 10:08:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904015424.1228665-1-marcharvey@google.com> <willemdebruijn.kernel.22c2bf5d2d4f3@gmail.com>
In-Reply-To: <willemdebruijn.kernel.22c2bf5d2d4f3@gmail.com>
From: Marc Harvey <marcharvey@google.com>
Date: Thu, 4 Sep 2025 10:08:46 -0700
X-Gm-Features: Ac12FXw49kSh6GKY2h7-eXe1I6WZ_M0sYCUqMpP9WWQchylNNQte6QMg8ZJMPxM
Message-ID: <CANkEMgmYHBw3YA5VBv20Y=BvjAx7a7b=YQfGPtmeFmDHvSauvw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] selftests: net: Add tests to verify team
 driver option set and get.
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: jiri@resnulli.us, andrew+netdev@lunn.ch, edumazet@google.com, 
	willemb@google.com, maheshb@google.com, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kuba@kernel.org, liuhangbin@gmail.com
Content-Type: text/plain; charset="UTF-8"

> >
> >  TEST_INCLUDES := \
> >       ../bonding/lag_lib.sh \
> >       ../../../net/forwarding/lib.sh \
> > -     ../../../net/lib.sh
> > +     ../../../net/lib.sh \
> > +     ../../../net/in_netns.sh \
> > +     ../../../net/lib/sh/defer.sh \
>
> Where is defer used? Also no backslash at last line.

Thank you for the review Willem.

Acknowledged for the backslash, will add in next iteration.

Defer is used by net/lib.sh. If defer.sh isn't included here, then the
test won't build correctly.

> > +attach_port_if_specified()
> > +{
> > +        local port_name="${1}"
>
> nit: parentheses around single character variable. Inconsistent.

Acknowledged, will add in the next iteration.

> > +#######################################
> > +# Test that an option's get value matches its set value.
> > +# Globals:
> > +#   RET - Used by testing infra like `check_err`.
> > +#   EXIT_STATUS - Used by `log_test` to whole script exit value.
> > +# Arguments:
> > +#   option_name - The name of the option.
> > +#   value_1 - The first value to try setting.
> > +#   value_2 - The second value to try setting.
> > +#   port_name - The (optional) name of the attached port.
> > +#######################################
>
> Just curious: is this a standard documentation format?

https://google.github.io/styleguide/shellguide.html#function-comments
But I will make these fit in better with the rest of the selftests.

>
> > +team_test_option()
> > +{
> > +        local option_name="$1"
> > +        local value_1="$2"
> > +        local value_2="$3"
> > +        local possible_values="$2 $3 $2"
> > +        local port_name="$4"
> > +        local port_flag
> > +
> > +        RET=0
> > +
> > +        echo "Setting '${option_name}' to '${value_1}' and '${value_2}'"
> > +
> > +        attach_port_if_specified "${port_name}"
> > +        check_err $? "Couldn't attach ${port_name} to master"
>
> Can the rest of the test continue if this command failed?

The test will fail, but the rest of the test will still run. That
being said, only the first error message is printed by the check_err
function.


>
> > +        port_flag=$(get_port_flag "${port_name}")
> > +
> > +        # Set and get both possible values.
> > +        for value in ${possible_values}; do
> > +                set_and_check_get "${option_name}" "${value}" "${port_flag}"
> > +                check_err $? "Failed to set '${option_name}' to '${value}'"
> > +        done
> > +
> > +        detach_port_if_specified "${port_name}"
> > +        check_err $? "Couldn't detach ${port_name} from its master"
> > +
> > +        log_test "Set + Get '${option_name}' test"
> > +}
>

