Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BD1614BD1
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 14:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiKANfD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 09:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiKANfC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 09:35:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2221C219B
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 06:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667309652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PKW8Pf1E15nZeyxIsBODYnAk76ngwldQbrSOxueGd64=;
        b=ACGDpqCsB8OqOGqg8sBPPs+x+i21xKryr8brujVY1Z7SE2jIclmyVEM+ENcahzPMXD2cn7
        kMwhaS6/u0QSlq2JzBxOcYU23+IlDj3lHVlSfiN75nwWTOqHI+2fvKosrQ9lrnasWmX0kU
        wTTdAx9FYXn4SJrYTAxfr3GK+1FcRG8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-fCgu297eO-KoonOoEZ4tQw-1; Tue, 01 Nov 2022 09:34:06 -0400
X-MC-Unique: fCgu297eO-KoonOoEZ4tQw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2716D1C0896B;
        Tue,  1 Nov 2022 13:34:05 +0000 (UTC)
Received: from fedora (unknown [10.22.32.201])
        by smtp.corp.redhat.com (Postfix) with SMTP id 62B504B4011;
        Tue,  1 Nov 2022 13:34:00 +0000 (UTC)
Date:   Tue, 1 Nov 2022 10:33:59 -0300
From:   Wander Lairson Costa <wander@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v16 2/3] virt: Add TDX guest driver
Message-ID: <20221101133359.r572wy7pku6e65dr@fedora>
References: <20221028002820.3303030-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20221028002820.3303030-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <Y1t18Aw2RbP+oj9D@kroah.com>
 <01f437c1-9330-6fb5-d692-6cd500d8adf8@linux.intel.com>
 <Y14fX1Ni1taUxtFk@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y14fX1Ni1taUxtFk@kroah.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Oct 30, 2022 at 07:53:19AM +0100, Greg Kroah-Hartman wrote:
> On Sat, Oct 29, 2022 at 04:17:39PM -0700, Sathyanarayanan Kuppuswamy wrote:
> > Hi Greg
> > 
> > On 10/27/22 11:25 PM, Greg Kroah-Hartman wrote:
> > > On Thu, Oct 27, 2022 at 05:28:19PM -0700, Kuppuswamy Sathyanarayanan wrote:
> > 
> > >> +
> > >> +static long tdx_guest_ioctl(struct file *file, unsigned int cmd,
> > >> +			    unsigned long arg)
> > >> +{
> > >> +	switch (cmd) {
> > >> +	case TDX_CMD_GET_REPORT:
> > >> +		return tdx_get_report((void __user *)arg);
> > > 
> > > You know the type of this pointer here, why not cast it instead of
> > > having to cast it from void * again?
> > 
> > The only place we use arg pointer is in copy_from_user() function,
> > which expects void __user * pointer. So why cast it as struct
> > tdx_report_req * here?
> 
> Because then your function will show the true type and you don't have to
> cast it again.
> 

If we are taking this route, isn't better to move the copy_from_user
call to tdx_guest_ioctl and pass the resulting struct tdx_report_req
pointer to tdx_get_report?

