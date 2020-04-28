Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304CA1BBDEF
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Apr 2020 14:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgD1MrC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Apr 2020 08:47:02 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41936 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726620AbgD1MrC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Apr 2020 08:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588078020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZOtjHDNu0KDnPhSIJu6AkpMfJD2kZB+yXoA3aP2tlrM=;
        b=UeqZfuh4P5unSOy/gswBoPHRSkq4kSC1sv5c4rFjp/4bcnXlAh+H2BD1PLhlbBa+Ghh5Fw
        +3sourSXQk1lmX7S4KlEXxRvqFsVWAT8ystBbO5xcHUUAne9H7fwB+fAjapnBfoksRgYVu
        G3FZbrLyO4PluFgAWc1/jjPdPNp45IY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-6MBHGPBPN8CDw4MxaZZY-Q-1; Tue, 28 Apr 2020 08:46:59 -0400
X-MC-Unique: 6MBHGPBPN8CDw4MxaZZY-Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66804462;
        Tue, 28 Apr 2020 12:46:58 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5AA4B5D9E2;
        Tue, 28 Apr 2020 12:46:58 +0000 (UTC)
Received: from zmail19.collab.prod.int.phx2.redhat.com (zmail19.collab.prod.int.phx2.redhat.com [10.5.83.22])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 4E5A81809540;
        Tue, 28 Apr 2020 12:46:58 +0000 (UTC)
Date:   Tue, 28 Apr 2020 08:46:58 -0400 (EDT)
From:   Veronika Kabatova <vkabatov@redhat.com>
To:     shuah <shuah@kernel.org>
Cc:     Stefano Brivio <sbrivio@redhat.com>,
        linux-kselftest@vger.kernel.org
Message-ID: <508944680.20946817.1588078018072.JavaMail.zimbra@redhat.com>
In-Reply-To: <bd179be3-2515-1efb-ba95-3c223d573753@kernel.org>
References: <20200427192141.2926018-1-vkabatov@redhat.com> <20200427212405.2747394d@redhat.com> <bd179be3-2515-1efb-ba95-3c223d573753@kernel.org>
Subject: Re: [PATCH] selftests: introduce gen_tar Makefile target
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.195.57, 10.4.195.28]
Thread-Topic: selftests: introduce gen_tar Makefile target
Thread-Index: Zo7uSNQzR0OovcwVHyt1LRWNWQs1IA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



----- Original Message -----
> From: "shuah" <shuah@kernel.org>
> To: "Stefano Brivio" <sbrivio@redhat.com>, "Veronika Kabatova" <vkabatov@redhat.com>
> Cc: linux-kselftest@vger.kernel.org, "shuah" <shuah@kernel.org>
> Sent: Tuesday, April 28, 2020 2:17:27 AM
> Subject: Re: [PATCH] selftests: introduce gen_tar Makefile target
> 
> Hi Veronika,
> 
> On 4/27/20 1:24 PM, Stefano Brivio wrote:
> > On Mon, 27 Apr 2020 21:21:41 +0200
> > Veronika Kabatova <vkabatov@redhat.com> wrote:
> > 
> >> The gen_kselftest_tar.sh always packages *all* selftests and doesn't
> >> pass along any variables to `make install` to influence what should be
> >> built. This can result in an early error on the command line ("Unknown
> >> tarball format TARGETS=XXX"), or unexpected test failures as the
> >> tarball contains tests people wanted to skip on purpose.
> >>
> >> Since the makefile already contains all the logic, we can add a target
> >> for packaging. Keep the default .gz target the script uses, and actually
> >> extend the supported formats by using tar's autodetection.
> >>
> >> To not break current workflows, keep the gen_kselftest_tar.sh script as
> >> it is, with an added suggestion to use the makefile target instead.
> >>
> >> Signed-off-by: Veronika Kabatova <vkabatov@redhat.com>
> > 
> > Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
> > 
> 
> I don't see this in my Inbox. Please include everybody get_maintainers
> script tells you to do.
> 
> You can add the Reviewed-by: Stefano Brivio <sbrivio@redhat.com> to the
> patch when you resend it.
> 

Hi Shuah,

apologies for the complications. As Stefano said, I did indeed include
you and the list in the recipients, but it looks like either a setup of
our internal smtp server or my git setup refuses to send the emails out
to some external recipients. Funnily enough, sending the email to my
private account works fine.

I resent the patch from my private account and I can see it on the list
now, please let me know there are any issues with the copy in your
inbox.


Veronika

> thanks,
> -- Shuah
> 
> 

