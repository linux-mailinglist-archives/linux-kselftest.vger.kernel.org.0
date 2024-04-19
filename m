Return-Path: <linux-kselftest+bounces-8396-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 056A48AA7FF
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 07:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 734941F21605
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 05:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8232BA2B;
	Fri, 19 Apr 2024 05:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="fkzF8foB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714437494;
	Fri, 19 Apr 2024 05:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713505287; cv=none; b=c5nkRRaSIauR0Om3TtCK9RBXt2ZYuYRYrdv2XfF/fT8jCIeL+xjOpZkXGwz2GsQjB7qhEpH4MQUgH4lHnFLEFRPnrI881wKrYxuoVrF39Ddvgxz+x/O0wSKZHfFGDg6cHmB41rUkkpuvsvLuiWiXtLkq8oUJz0z6E+KexqaD9PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713505287; c=relaxed/simple;
	bh=dxRSEz5EcO0H9V9Pir7Cuzg5aLS6zX2g3zh3ZnaYBRY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=FDhiU/Ril/q3Rzlno1xxItp+s3GshaxNhrIfdi8QnblVI0hyfWH/HK63TSQ/IAA0aZeIrrkzyl5r4CgO2zetyKcI+VNaKEY9w7WnEpuy82Om+kI3mpcNrnF4XGquYLDVdIAbP5pXulWVu6QqeyvzLAG99TL/FdT5NtDJW2/ERKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=fkzF8foB; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713505263; x=1714110063; i=markus.elfring@web.de;
	bh=kAavMo0zT0MnjGzC6Vpu4OCbYey8NotUhupnbX9R08M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fkzF8foBx8/grg7hI21gs11g7sfyC1ETQwpvom97YiOx2C04hSSsmcQoImtbSt6M
	 AOHtP24pcYbyqy21KCEBFmNZrzD0O8KLIYu/OL8MAr3VE9WIjgWPOw6JLUaZHyiEl
	 Zh0ryIyaEx2bQHQZ3aCNl4txTVPiCIzZM+zgb+zE/BMN4YGIyUYUO+74PP9ZQWOZp
	 4R1dbbo3NqbEanaVBioc06f7b/Ihe61icF3Yo32yDr1AIzlzz19G/R74CwbzI4Poo
	 DR9BN2Rz2FHsLrso2DvUFJPzYfI15U8OR25GtA8/GMn+b3nXyc8PqxGfHHswujuX2
	 hHD8w/w70BDC8YOYQw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MMpCS-1sGSpX2Hrw-00Iodt; Fri, 19
 Apr 2024 07:41:03 +0200
Message-ID: <405247be-09e9-4a2d-9363-93b5862fc615@web.de>
Date: Fri, 19 Apr 2024 07:40:43 +0200
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
References: <20240418210236.194190-2-wander@redhat.com>
Subject: Re: [PATCH v3 1/2] kunit: unregister the device on error
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240418210236.194190-2-wander@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:/detqtdc+F1ysEKuBRbVEjDKPuYX8yypEqNgRwClaU8w5xI0iV/
 j94OaIuGK7iIETaDob4X7ivWKE4WkMywvNC6/iAtSWE3n+PyLoVWozxq7WqegA2JC0RH7f6
 d0JplDAUwKKv0bcpBTZHxuQo5GsJ6VU4v4lSdygq4Uu6tfgJR5kRN0jWa/zRdmIP9Gndxee
 fwjzZghoNg0Rit17kWyYQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:faEoMuu3f2A=;uSRy3bbRQp6ZsYIBxt02ZewLhkK
 89AoODOOFw6GOAujBoUoyoVZoBab9gfXx+c2CQeFDymkM2021ffh3Cpg4SX12QGAt8kCn0enH
 c6DOY9NEPrh0hDlypP4ihw3kcElJaziHg7QwS3nA1fbA82d8JuI5gbunQUwJmKQCMGSr+Vm4f
 BL3h2yOc6gs5mhRjo6KH5Fz4oR7ShKBVQZei0RD4/YEkiee2XY3N9eZ8sWRxpyMolMt8/TwWx
 n10TspMr0lM8FnUU3Fbit5YcN54SgTdRb7Y2HvkV1RwknR3q7tG4TM80K9QAo7vqHZvU6kuda
 OmbJyY6QpMhUjSvuUM/OxwJEPODf4u/nXQImZi9DVwSOOL98O+AOLLy/AePV3AgIKBOrAJRLJ
 czuRf7ANMFaX6ubQd14SovGMxf13Hq26B36nMeb8JH6zwvJ+9WfkXoNPRx7En6e74H8P2i+lN
 DS60Aep4Gkwobj7tCvWlE2IlUJcoUf10Vk2GVPaNS/r02FoBZrYHSLPhd26F2If/+P5aNBdPZ
 hYaLZBop4OInQ3Mw7hH9tnSfdBd4hx6lWGScJExGPtOc2+mPRFXKZ5uzlNqWUv7MttrxJj1QK
 +880eogH4nzY3HmpycnH+ALHqPpEq3nktIAfCf+MsApQ/j2fwEI38Ir/nAMJnNQ0PQSNYgsh3
 UV82Z+osnrOLStciSXfad2i7QDd80s+JjbpDQBxexTEmwf6SJiDlaXbL71S3toY3PWz3UeEuV
 NRXdtfdF2R45Vms7KbwuhgovGhjrU6WQQbJIL3xQz38zfT+gcuPhyhVCMDsHSJaTYecOoE2w+
 Khyu0eMu4k3cYQBCFBut7NX+cYiFNEwIw6axbpY97OaUY=

> kunit_init_device() should unregister the device on bus register error,
> but mistakenly it tries to unregister the bus.

Would the following description variant be more appropriate?

   kunit_init_device() should unregister the device on bus registration error.
   But it mistakenly tries to unregister the bus.


Regards,
Markus

