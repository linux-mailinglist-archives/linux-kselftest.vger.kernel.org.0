Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73EDF1C3896
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 May 2020 13:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbgEDLuF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 May 2020 07:50:05 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55966 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726756AbgEDLuF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 May 2020 07:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588593003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7hyf/LHgghd5mqY1mbkWHgQZ+YGXmwDLr14zfzKYF4E=;
        b=Vu4nE9hmi+05M642uX1XzgGM0Phbk8STlvUXYi4bsUB/v9vHXw0eUf1NMJBfyLCsG0CjF7
        bezVV1+Cbilg55H9rSzo17eycJR5QYL5V/Wje0TBeedZpGtkc+mEE0f7/y07v5etGcEd+5
        jiit67aa26BuhVjzwh+/7/jllJX+VQA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-pSOLKiorODKyUFALXXeVRg-1; Mon, 04 May 2020 07:50:01 -0400
X-MC-Unique: pSOLKiorODKyUFALXXeVRg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B583C107ACF5;
        Mon,  4 May 2020 11:50:00 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AC72360BEC;
        Mon,  4 May 2020 11:50:00 +0000 (UTC)
Received: from zmail19.collab.prod.int.phx2.redhat.com (zmail19.collab.prod.int.phx2.redhat.com [10.5.83.22])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id A25234CA94;
        Mon,  4 May 2020 11:50:00 +0000 (UTC)
Date:   Mon, 4 May 2020 07:50:00 -0400 (EDT)
From:   Veronika Kabatova <vkabatov@redhat.com>
To:     shuah <shuah@kernel.org>
Cc:     Veronika Kabatova <veronicca114@gmail.com>, sbrivio@redhat.com,
        linux-kselftest@vger.kernel.org
Message-ID: <687583033.21650764.1588593000351.JavaMail.zimbra@redhat.com>
In-Reply-To: <529c2308-0840-a794-fc09-d44272066b08@kernel.org>
References: <20200428123841.2953099-1-vkabatov@redhat.com> <529c2308-0840-a794-fc09-d44272066b08@kernel.org>
Subject: Re: [PATCH] selftests: introduce gen_tar Makefile target
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.195.208, 10.4.195.8]
Thread-Topic: selftests: introduce gen_tar Makefile target
Thread-Index: bPQtyLMcESjoyXQpKolgQIdGz4fLuQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



----- Original Message -----
> From: "shuah" <shuah@kernel.org>
> To: "Veronika Kabatova" <veronicca114@gmail.com>
> Cc: sbrivio@redhat.com, linux-kselftest@vger.kernel.org, "Veronika Kabatova" <vkabatov@redhat.com>, "shuah"
> <shuah@kernel.org>
> Sent: Friday, May 1, 2020 4:49:34 PM
> Subject: Re: [PATCH] selftests: introduce gen_tar Makefile target
> 
> Hi Veronica,
> 

Hi,

> On 4/28/20 6:38 AM, Veronika Kabatova wrote:
> > The gen_kselftest_tar.sh always packages *all* selftests and doesn't
> > pass along any variables to `make install` to influence what should be
> > built. This can result in an early error on the command line ("Unknown
> > tarball format TARGETS=XXX"), or unexpected test failures as the
> > tarball contains tests people wanted to skip on purpose.
> > 
> > Since the makefile already contains all the logic, we can add a target
> > for packaging. Keep the default .gz target the script uses, and actually
> > extend the supported formats by using tar's autodetection.
> > 
> 
> Thanks for working on this. gen_kselftest_tar.sh  a while back before a
> lot of the install features went in and Makefile supports it fully. It
> makes perfect sense to use Makefile drive this.
> 
> > To not break current workflows, keep the gen_kselftest_tar.sh script as
> > it is, with an added suggestion to use the makefile target instead.
> > 
> 
> Not sure how many people use this. It is a good idea keeping it around
> for now.
> 
> > Signed-off-by: Veronika Kabatova <vkabatov@redhat.com>
> > Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
> > ---
> >   Documentation/dev-tools/kselftest.rst        | 23 ++++++++++++++++++++
> >   tools/testing/selftests/Makefile             |  9 +++++++-
> >   tools/testing/selftests/gen_kselftest_tar.sh |  5 +++++
> >   3 files changed, 36 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/dev-tools/kselftest.rst
> > b/Documentation/dev-tools/kselftest.rst
> > index 61ae13c44f91..3fc559bcb597 100644
> > --- a/Documentation/dev-tools/kselftest.rst
> > +++ b/Documentation/dev-tools/kselftest.rst
> > @@ -151,6 +151,29 @@ note some tests will require root privileges::
> >      $ cd kselftest
> >      $ ./run_kselftest.sh
> >   
> > +Packaging selftests
> > +===================
> > +
> > +In some cases packaging is desired, such as when tests need to run on a
> > +different system. To package selftests, run::
> > +
> > +   $ make -C tools/testing/selftests gen_tar
> > +
> 
> Does this work in the case of relocatable build.cross-build cases?
> 
> > +This generates a tarball in the `INSTALL_PATH/kselftest-packages`
> > directory. By
> > +default, `.gz` format is used. The tar format can be overriden by
> > specifying
> > +a `FORMAT` make variable. Any value recognized by `tar's auto-compress`_
> > option
> > +is supported, such as::
> > +
> > +    $ make -C tools/testing/selftests gen_tar FORMAT=.xz
> > +
> > +`make gen_tar` invokes `make install` so you can use it to package a
> > subset of
> > +tests by using variables specified in `Running a subset of selftests`_
> > +section::
> > +
> > +    $ make -C tools/testing/selftests gen_tar TARGETS="bpf" FORMAT=.xz
> 
> Does this work in the case of relocatable build.cross-build cases?
> 

The command only adds a "tar" call on top of "make install" and doesn't
reach outside of INSTALL_PATH. If the cases you mention are supported by
the regular "make install" then they should work with "gen_tar" as well.



Veronika

> Please try these cases as well and let me know.
> 
> I would like to get this in for 5.8-rc1.
> 
> thanks,
> -- Shuah
> 
> 

