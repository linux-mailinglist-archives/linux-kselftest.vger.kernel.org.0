Return-Path: <linux-kselftest+bounces-3186-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1C4831449
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 09:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 134101F2451A
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 08:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3B4BE67;
	Thu, 18 Jan 2024 08:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c2vrkNzH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CF713AF9
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Jan 2024 08:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705565642; cv=none; b=FVP+LIR/sY/B10DZpvckoR7vPEsl8u6HjtLc0/VgleJm1BXwXnW0EUghjg+YVB89uESR1+Iy/ZAYHLx91grangvQOzQ1PtLjbaXUsCh5vvnTSCtcbuZdaiLIi+1G9Ln5HMY7NiZrmUH6OeKJ2/rLpVcoSfr3mS1YOKz4fXis1og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705565642; c=relaxed/simple;
	bh=VAdc1NKbCLJXB5ZwNWmpBl+bYEPBUTw+cW5ZgUWrUe4=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding; b=nHNMMFG5PtLeNZb6HrWyr/yS7JS1lBSLsz9Hb5U3ORVkDv99hSFq1jfmZTOXyv0LjwSRQhHbvvenHpV2FE/xHiPMZEBPp788hI5xHla1828DAHHKP0xYCRe18yN2l99wtyFR4SsV2neGg32/cH9esXNCC8+83zK/8oOjcuIGv0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c2vrkNzH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705565640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5SsqaeFnNlDjnwQj4dzfPpX8ZsfHI+luLg/Td8wcFQ4=;
	b=c2vrkNzHhDE91WQxnpsCO0/zCEk7WMSI0aTUEiVZcq2k0LTk80Auyc7S9vztZ0ruzeW01r
	JhXHRtUwd1cEh+Bpl2/7fUxeLwkv+vWPiis/HdM9yHvqkbOgJArwXR7qqnsA9tkNUoMkkV
	VoWwZ9jNYyfa3FPtrsxxpyDmNBe5puU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-5haLVL7YN--dH3g6AKQNpQ-1; Thu, 18 Jan 2024 03:13:57 -0500
X-MC-Unique: 5haLVL7YN--dH3g6AKQNpQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a26f2da3c7bso493793666b.0
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Jan 2024 00:13:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705565636; x=1706170436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SsqaeFnNlDjnwQj4dzfPpX8ZsfHI+luLg/Td8wcFQ4=;
        b=qJnphBRsAgXkYFdY6FNOe8y90L2idgc1UHo8lnXoJQSRnan4l03ru9Wgm/HWBGyYgx
         IC65zpt1MsoROHkTsFWLGEbrGRhSh1ctA8FwKXtiaRvkwnhU4+hxvYC4eoaECknepXNq
         UCFQ6HIOHCGAf0Mv/6o9xmeWi+Syl/Ba3khPrOquXED8RBZCMizbYXkUpTtwQUlx8Vw1
         4Zytzm4/tvuqQ8TAiPBhxf3lbZaUtct9jkiNgevNEoYpixwEwNPA0OifjhVhyYFTlLkl
         6djFEUS3oKXa/+kap7FGJbzMFGjLODgLDPRGxt1hIRJ1gcgtUsg03hQkFISb77OqJrHE
         AXJQ==
X-Gm-Message-State: AOJu0YwWx/NnFwfWhPObmBqwsGRrbErQAHDoAFCp73qrzF6HfU1FIflt
	pGygyfJ8E8I9PPsELfL3jDr2IWqDEOyKOtwaZmepCFOYiiIO/i7EsccspJX+NH2FFnX/2mpeT/Q
	Bu8eY5Euns5ycQ0PucvHZ/Y1Fw5mvlx40/Pb3qaeXmATwiovQbjySw58lVQf8V1YIvf5rsnIXxB
	lVvwlCNHfaLDH+W2CsYkcPzgm4JTER3veicWrugeXh
X-Received: by 2002:a17:906:f746:b0:a26:97fe:b8cc with SMTP id jp6-20020a170906f74600b00a2697feb8ccmr266443ejb.66.1705565636473;
        Thu, 18 Jan 2024 00:13:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEC3cI8HvUGHgz6IrmlJYZMRWTXEOiyQ0Xwp7Yv8XXR/9cy35jOph4av3RGpi+WCBaGGtcY/I8OUZfAk0dVXVw=
X-Received: by 2002:a17:906:f746:b0:a26:97fe:b8cc with SMTP id
 jp6-20020a170906f74600b00a2697feb8ccmr266431ejb.66.1705565636180; Thu, 18 Jan
 2024 00:13:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-b4-wip-wacom-tests-fixes-v1-1-f317784f3c36@kernel.org> <CANRwn3QhYtuiGemwrf6_bYDDeAU0GrPm7T9ca3OzQaX8vGKPEQ@mail.gmail.com>
In-Reply-To: <CANRwn3QhYtuiGemwrf6_bYDDeAU0GrPm7T9ca3OzQaX8vGKPEQ@mail.gmail.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Thu, 18 Jan 2024 09:13:44 +0100
Message-ID: <CAO-hwJ+n7Bv8UgNaDCEtqoU=DWVxxVUJ7y+=nj_PKmrdtgorkA@mail.gmail.com>
Subject: Re: [PATCH] selftests/hid: wacom: fix confidence tests
To: Jason Gerecke <killertofu@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Jason Gerecke <jason.gerecke@wacom.com>, linux-input@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 7:12=E2=80=AFPM Jason Gerecke <killertofu@gmail.com=
> wrote:
>
> LGTM. Acked-by: Jason Gerecke <jason.gerecke@wacom.com>

Thanks!

I'll add a:
Fixes: b0fb904d074e ("HID: wacom: Add additional tests of confidence behavi=
or")

And send to Linus in the next round for 6.8 so we also fix the future
for-6.9 branches

Cheers,
Benjamin


>
>
> Jason
> ---
> Now instead of four in the eights place /
> you=E2=80=99ve got three, =E2=80=98Cause you added one  /
> (That is to say, eight) to the two,     /
> But you can=E2=80=99t take seven from three,    /
> So you look at the sixty-fours....
>
>
>
> On Wed, Jan 17, 2024 at 5:27=E2=80=AFAM Benjamin Tissoires <bentiss@kerne=
l.org> wrote:
>>
>> The device is exported with a fuzz of 4, meaning that the `+ t` here
>> is removed by the fuzz algorithm, making those tests failing.
>>
>> Not sure why, but when I run this locally it was passing, but not in the
>> VM.
>>
>> Link: https://gitlab.freedesktop.org/bentiss/hid/-/jobs/53692957#L3315
>> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
>> ---
>> Over the break the test suite wasn't properly running on my runner,
>> and this small issue sneaked in.
>> ---
>>  tools/testing/selftests/hid/tests/test_wacom_generic.py | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/testing/selftests/hid/tests/test_wacom_generic.py b/t=
ools/testing/selftests/hid/tests/test_wacom_generic.py
>> index 352fc39f3c6c..b62c7dba6777 100644
>> --- a/tools/testing/selftests/hid/tests/test_wacom_generic.py
>> +++ b/tools/testing/selftests/hid/tests/test_wacom_generic.py
>> @@ -880,8 +880,8 @@ class TestDTH2452Tablet(test_multitouch.BaseTest.Tes=
tMultitouch, TouchTabletTest
>>          does not overlap with other contacts. The value of `t` may be
>>          incremented over time to move the point along a linear path.
>>          """
>> -        x =3D 50 + 10 * contact_id + t
>> -        y =3D 100 + 100 * contact_id + t
>> +        x =3D 50 + 10 * contact_id + t * 11
>> +        y =3D 100 + 100 * contact_id + t * 11
>>          return test_multitouch.Touch(contact_id, x, y)
>>
>>      def make_contacts(self, n, t=3D0):
>> @@ -902,8 +902,8 @@ class TestDTH2452Tablet(test_multitouch.BaseTest.Tes=
tMultitouch, TouchTabletTest
>>          tracking_id =3D contact_ids.tracking_id
>>          slot_num =3D contact_ids.slot_num
>>
>> -        x =3D 50 + 10 * contact_id + t
>> -        y =3D 100 + 100 * contact_id + t
>> +        x =3D 50 + 10 * contact_id + t * 11
>> +        y =3D 100 + 100 * contact_id + t * 11
>>
>>          # If the data isn't supposed to be stored in any slots, there i=
s
>>          # nothing we can check for in the evdev stream.
>>
>> ---
>> base-commit: 80d5a73edcfbd1d8d6a4c2b755873c5d63a1ebd7
>> change-id: 20240117-b4-wip-wacom-tests-fixes-298b50bea47f
>>
>> Best regards,
>> --
>> Benjamin Tissoires <bentiss@kernel.org>
>>
>>


