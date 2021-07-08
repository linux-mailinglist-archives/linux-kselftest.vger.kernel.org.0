Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41543BF2DB
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jul 2021 02:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhGHAaH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jul 2021 20:30:07 -0400
Received: from mx1.riseup.net ([198.252.153.129]:54090 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230000AbhGHAaH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jul 2021 20:30:07 -0400
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4GKxvL3wwkzDq8f;
        Wed,  7 Jul 2021 17:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1625704046; bh=aXuc9rNd9kvHVPjhHfEZCfK/+vWKAZXmuWBbVi7CygI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YN1X3JcsPMaV/P4nTTseh9qBhR3iMYyT7YdHF6oxGxN+qN+Jhh4sv2JyCR4iqqcc9
         jvFin3JoKfaJLUa+ax7VxvlT+6RHYzEFUIoNDHoqMebZ9h3jrnMgfVolhCsMCmyQqy
         1unasXAxzN3RytwU9JjknNZ9C6jXwnUFuaty6GMA=
X-Riseup-User-ID: BE33A9AFCB6356FBEADA5FC50C0ECDD3C3292DC384BDE458CB9091660712290B
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4GKxvH6QMBz5vYh;
        Wed,  7 Jul 2021 17:27:23 -0700 (PDT)
Subject: Re: KUnit Hackathon
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, ~lkcamp/discussion@lists.sr.ht,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <n@nfraprado.net>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Leandro Ribeiro <leandrohr@riseup.net>,
        kernel-usp@googlegroups.com
References: <83ff3ed3-e004-29b2-b23c-a2ba4d5a3f7f@riseup.net>
 <CAFd5g45rE4+ChY86KN7wPcjGtQAwUqQWccEMMWW-=7mz2oTwGg@mail.gmail.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@riseup.net>
Message-ID: <a60528cf-f787-2989-6a17-baa9e24fca8c@riseup.net>
Date:   Wed, 7 Jul 2021 21:27:22 -0300
MIME-Version: 1.0
In-Reply-To: <CAFd5g45rE4+ChY86KN7wPcjGtQAwUqQWccEMMWW-=7mz2oTwGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Brendan,

Às 17:23 de 07/07/21, Brendan Higgins escreveu:
> On Mon, Jul 5, 2021 at 1:41 PM André Almeida <andrealmeid@riseup.net> wrote:
>>
>> Hello,
>>
>> We belong to two student groups, FLUSP [1] and LKCAMP [2], both of which
>> are focused on sharing kernel and free software development knowledge
>> and experience with fellow free software developers and newcomers.
>>
>> As part of our efforts, we'll be organizing a KUnit hackathon in the
>> next Saturday (July 10), where we intend to help newcomers convert
>> existing runtime tests (the ones found at lib/) to KUnit and maybe
>> create new ones. Depending on the number of attendees, a high volume of
>> patches may be sent throughout the day. We will do our best to review
>> all patches before they go to the kernel mailing lists hoping to avoid
>> wasting your time with minor patching issues.
> 
> That's awesome! I'm really excited!

:D

> 
>> So we wanted to let you know of all this beforehand and give you the
>> time to send any suggestions or comments on all this. For instance, we
>> may ask people to add a special tag to their patches so you may batch
>> review them all at a later time if you wish.
> 
> I wouldn't worry about it until it becomes an actual "problem"; too
> many patches is a good problem to have :-)
> 
>> Anyhow, we'd really appreciate having your opinion on this.
> 
> I don't think I have anything to add that Daniel didn't already add in
> his reply. Also, I have seen Marcelo around for a while. I have to
> say, I don't think I have seen a student group this involved upstream.
> I am impressed :-)
> 
>> Thanks!
> 
> Thank *you*!
> 
> I wish I could offer more material assistance, but with only a week's
> notice, I don't think I can. I will try to be online periodically
> throughout the day, but I am afraid I cannot promise anything.
> 
> No matter what, we would be somewhat limited with what we can do in
> 2021 because of COVID. No promises, but if this goes well maybe next
> year we might be able to send someone in person if that's something
> you would be interested in.

Wow, that would be really awesome!

> 
> Best of luck! I hope it goes well!

Thank you for the support! Next time, I'll make sure to send this notice
earlier

> 
>> [1] - https://flusp.ime.usp.br/
>> [2] - https://lkcamp.dev/
