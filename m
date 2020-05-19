Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223E01DA152
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 May 2020 21:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgESTvB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 May 2020 15:51:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34141 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726643AbgESTvB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 May 2020 15:51:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589917859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ATCqYOSghN4+w4h5JMu3321ql/sjpzsjQo34h345RKE=;
        b=AIxDk6Jk88ycYmYWPApZiemmFy3lgHod30hzuGpjvCg5S2YK60wJKlZbXEUgjVmQGoR1MR
        3r8QabqX4SE0PNdq8UntsVkyDySM0l/6grv0qLX7ymptkOYUQNur1MYSPbQs90MVToIVsc
        F7TBhUK+kyoOmqxmnvUikZ5hfOZbnIg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-AxYRYGU8OW2Y4pm6jMTSAQ-1; Tue, 19 May 2020 15:50:55 -0400
X-MC-Unique: AxYRYGU8OW2Y4pm6jMTSAQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1F7E107B266;
        Tue, 19 May 2020 19:50:54 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CA2B31001B2C;
        Tue, 19 May 2020 19:50:54 +0000 (UTC)
Received: from zmail19.collab.prod.int.phx2.redhat.com (zmail19.collab.prod.int.phx2.redhat.com [10.5.83.22])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id C236C4ED87;
        Tue, 19 May 2020 19:50:54 +0000 (UTC)
Date:   Tue, 19 May 2020 15:50:54 -0400 (EDT)
From:   Veronika Kabatova <vkabatov@redhat.com>
To:     shuah <shuah@kernel.org>
Cc:     sbrivio@redhat.com, linux-kselftest@vger.kernel.org
Message-ID: <45315971.23643916.1589917854550.JavaMail.zimbra@redhat.com>
In-Reply-To: <cb18f49a-02aa-4a85-a80d-e991254cd6b9@kernel.org>
References: <20200428123841.2953099-1-vkabatov@redhat.com> <529c2308-0840-a794-fc09-d44272066b08@kernel.org> <687583033.21650764.1588593000351.JavaMail.zimbra@redhat.com> <492228e8-9762-dfe9-8cb6-534c8e6171b9@kernel.org> <cb18f49a-02aa-4a85-a80d-e991254cd6b9@kernel.org>
Subject: Re: [PATCH] selftests: introduce gen_tar Makefile target
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.40.196.38, 10.4.195.20]
Thread-Topic: selftests: introduce gen_tar Makefile target
Thread-Index: ioEK4iVIpzlGRIowjyRjeP5QMCAMwQ==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



----- Original Message -----
> From: "shuah" <shuah@kernel.org>
> To: "Veronika Kabatova" <vkabatov@redhat.com>
> Cc: "Veronika Kabatova" <veronicca114@gmail.com>, sbrivio@redhat.com, lin=
ux-kselftest@vger.kernel.org, "shuah"
> <shuah@kernel.org>
> Sent: Tuesday, May 19, 2020 8:39:23 PM
> Subject: Re: [PATCH] selftests: introduce gen_tar Makefile target
>=20
> Hi Veronika,
>=20
> On 5/6/20 8:56 AM, shuah wrote:
> > On 5/4/20 5:50 AM, Veronika Kabatova wrote:
> >>
> >>
> >> ----- Original Message -----
> >>> From: "shuah" <shuah@kernel.org>
> >>> To: "Veronika Kabatova" <veronicca114@gmail.com>
> >>> Cc: sbrivio@redhat.com, linux-kselftest@vger.kernel.org, "Veronika
> >>> Kabatova" <vkabatov@redhat.com>, "shuah"
> >>> <shuah@kernel.org>
> >>> Sent: Friday, May 1, 2020 4:49:34 PM
> >>> Subject: Re: [PATCH] selftests: introduce gen_tar Makefile target
> >>>
> >>> Hi Veronica,
> >>>
> >>
> >> Hi,
> >>
> >>> On 4/28/20 6:38 AM, Veronika Kabatova wrote:
> >>>> The gen_kselftest_tar.sh always packages *all* selftests and doesn't
> >>>> pass along any variables to `make install` to influence what should =
be
> >>>> built. This can result in an early error on the command line ("Unkno=
wn
> >>>> tarball format TARGETS=3DXXX"), or unexpected test failures as the
> >>>> tarball contains tests people wanted to skip on purpose.
> >>>>
> >>>> Since the makefile already contains all the logic, we can add a targ=
et
> >>>> for packaging. Keep the default .gz target the script uses, and
> >>>> actually
> >>>> extend the supported formats by using tar's autodetection.
> >>>>
> >>>
> >>> Thanks for working on this. gen_kselftest_tar.sh=C2=A0 a while back b=
efore a
> >>> lot of the install features went in and Makefile supports it fully. I=
t
> >>> makes perfect sense to use Makefile drive this.
> >>>
> >>>> To not break current workflows, keep the gen_kselftest_tar.sh script=
 as
> >>>> it is, with an added suggestion to use the makefile target instead.
> >>>>
> >>>
> >>> Not sure how many people use this. It is a good idea keeping it aroun=
d
> >>> for now.
> >>>
> >>>> Signed-off-by: Veronika Kabatova <vkabatov@redhat.com>
>=20
> There is a mispatch between your from email address and signed-off line.
> Please make sure they match.
>=20
> Also there is a spelling error in the document.
>=20
>=20
> WARNING: 'overriden' may be misspelled - perhaps 'overridden'?
> #125: FILE: Documentation/dev-tools/kselftest.rst:163:
> +default, `.gz` format is used. The tar format can be overriden by
> specifying
>=20

Thanks for pointing it out.

> WARNING: Missing Signed-off-by: line by nominal patch author 'Veronika
> Kabatova <veronicca114@gmail.com>'
>=20

Yes, that's because the work email decided to drop some public addresses
and the original patch didn't make it to you or the list. We got it fixed
so I'll send a v2 from there in a minute, sorry for the trouble.


Veronika

> Please fix them and sen me v2.
>=20
> thanks,
> -- Shuah
>=20
>=20

