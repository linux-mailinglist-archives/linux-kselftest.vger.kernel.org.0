Return-Path: <linux-kselftest+bounces-8402-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1858AA84E
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 08:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A150284174
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 06:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5A6C144;
	Fri, 19 Apr 2024 06:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="jPEmfXN1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB8FB667;
	Fri, 19 Apr 2024 06:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713507342; cv=none; b=dSsE58/dr28tPxHPkyYsBAXUvNodJsiJhjfWieIOMiGf4F8YnKHbftCzoYglqSKZTpx20nF7WznFnEUWnr6iUyAxBP4a0hEu5Rfen09gfz+xBR6FfvqxIYxCoN5nPh2WT/fldAxGj0IsG7SDoxse7DVNSAN847nZrOdxYtfzYiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713507342; c=relaxed/simple;
	bh=QE1SDfhNjvPtChP7Aj1UbHskIeF99ihKXjAVio0OQFI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=btk/UCmA+lRApc4tHqk/z0zH8esiGmldSuJZt2wvudg8ss9BQCz83orrLjTJfZlH9LLyxoJ/qpL6FlD5PUM1gwA76TkDg8igLDCDNcOix4IPdZiLzyBhQA1gYOOMV3sJRVU2y12x87mfcNuiN/748Qi60Wg3l9WNXR6Z5L54tQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=jPEmfXN1; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713507326; x=1714112126; i=markus.elfring@web.de;
	bh=SZj8ghAjaLE6nyctSaVo0FKCiOsfPBVQxbO6b2IlqcU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jPEmfXN1C7JBdJLHpnDWAqi+4KlfDrwl0j6uaHfBQms2mAPneVjv122no8KQW7St
	 uQLwBBzmINXWbvxrmsrN8LOPy8EDIy5W4mMZ0h1ZlB75Na6owz7xvr3ULETZU+86x
	 n/xqkEQ4WB+/TpDZ1O13xEMZGBPJWPveTUvg5N8Q83yrNRLCyMHEW7JRWu1nBXyq7
	 GSK+R5vSrPA/5wPkVATbTfZ4qd/d0SRbjZI78FixCbBrsU82xGws9sD753QG5lxmD
	 kUML4tFHiNLioa9S/3wVMbxz198qcmub8zotBJMsbYU10taDwvTlV6gCKRntTU8UO
	 3K2woMyP8ArF10Rnbg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mi4yz-1sbj6l2DtR-00e4QZ; Fri, 19
 Apr 2024 08:15:26 +0200
Message-ID: <b18c2e4b-bf61-41ad-b5f9-8e52d7651cca@web.de>
Date: Fri, 19 Apr 2024 08:15:25 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wander Lairson Costa <wander@redhat.com>, kunit-dev@googlegroups.com,
 linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Rae Moar <rmoar@google.com>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240418210236.194190-3-wander@redhat.com>
Subject: Re: [PATCH v3 2/2] kunit: avoid memory leak on device register error
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240418210236.194190-3-wander@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZP2boipMNyD0mUm2bcuILUQveBlG0LOrEz6OlCpvASrlP3tL2JY
 NcsIIynp8Eo239IN/by3VEO+uIe8DYM1TMM5mk3WVh/0jRhnAfvT6XgrY6VoKpwn980i24O
 MoW3W7z1VbvroUsD76AZdKwsFE88Z8K1MPo5OOQvnY44GFxOxe9AqpXBXDp+pt/8+KfZIG5
 s2+aW6/gzdSAHAv2T1pJg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3TBxCb/ezkM=;2p/RewvegXEDpauwRjt8uiNch3s
 BH9X8Z6Ifc02VySwy7N/3ezTh1/yaBHXewJLwqZ3XkTONVbAtZm53zjAUKPxXk+hAlQnHkuPl
 bAa9qPs72S/lN/xINB5gpjYiDZKSuW40KY4zWPjWms1ab69T7wMJ1+d+3TGxFXBNviWzX0KHI
 ibPH+jyyroU9jgHpNL4nPiTRiNjH1o70oXhUab9dYtdxxQbJL4ehHHdBEYsv0LDKoZ+1b/WWe
 YTCzyCe30fMQeelSK4iwj7m0xgVAcWCHahDE57LH3bKIo+rotVhH1ks99nSyPpxqHcmV0OnF1
 YwtsXYy9IzLC0fJL4vSyaHiq8xo6WDkERga++NBY60Tny654I1c+DPbtHSwZ8lvstFrqlk8AR
 DrXqpO9sTtlZ61PVHmGH7dsHt81+dBeM64diTS+fHJ/Ch5Gxo2WlVgx7gl1r3nfMCXjD+iW/n
 mfQUyfvlB+T0/EfzNLYCR02OHVLTEyGGjn/1PIHj8EfDMOzXFL542fj3xbP42djJxOizxRLlc
 /Ck03GxTgyIGoLiAZI1b1vsTT1MMaoHFzk1EXtf8nNk5HvNq/kROZ1gBg/d5jjuL1MYwLXVWf
 2mgccO115L2ARCk3npieuIVAzTMiOOEpZ+eHsd+Ed9FclhQ7EIQed92fAMtBCABOWiE0XUxNa
 JIwwTOnk3rJCzzwsq0DvYiD1To9omy6HAnfeROv+hXSejQvhuexmTGr8bvu4rMZkXo007Jtv/
 nVvO5I1t+ntMT6XEg4Y0uKIfM7QSWofLkg1SGiUSq+QjnvTP5CVLMR8qR4swN7gHW8/YrjqbT
 Rp3tRDZZ9YjYiLcDmU+zjdxNOP6+/wnPodaCdCYHuj0OQ=

> If the device register fails, free the allocated memory before
> returning.

Can a description variant (like the following) be more appropriate?

   Free the allocated memory (after a device registration failure)
   before returning.
   Thus add a jump target so that a bit of exception handling can be bette=
r
   reused at the end of this function implementation.


Would you like to replace the word =E2=80=9Cregister=E2=80=9D by =E2=80=9C=
registration=E2=80=9D also
in the summary phrase?


=E2=80=A6
> +++ b/lib/kunit/device.c
=E2=80=A6
> @@ -140,6 +138,9 @@ static struct kunit_device *kunit_device_register_in=
ternal(struct kunit *test,
>  	kunit_add_action(test, device_unregister_wrapper, &kunit_dev->dev);
>
>  	return kunit_dev;
> +error:
> +	kfree(kunit_dev);
> +	return ERR_PTR(err);
>  }
=E2=80=A6

I find it nicer to use a label like free_device.

Regards,
Markus

