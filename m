Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E7845B7B9
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Nov 2021 10:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbhKXJtU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Nov 2021 04:49:20 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:53787 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229840AbhKXJtT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Nov 2021 04:49:19 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id AB7105805EB;
        Wed, 24 Nov 2021 04:46:08 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 24 Nov 2021 04:46:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=DWpYJHZ7C02OmWS9zpShdVrwGV4
        F/Bj3lGFh/gah9uo=; b=mpVWzDRpZl3kZXdNXML588FQ6p1ZRiJPqRYCv8mTTRe
        JSiceWwZT36YAfjujBP82r4I4zEgbkXBnlaDXvOpi42jyHwXDJIVz2dvb+V4ZBCL
        fVWRwNIaZs85tgQx3lH7qHa8PuPxegE0SJn+szhmRYJjFw3t7jemI/yQaWfEiHeR
        oO4Knw/CiOGcgx4eeLU9LX2/6t//ET+vlDxTIB6GeI8fsM8O096FBDN70w/+v0UO
        kWSlLRA3GvYVPOJdxiNhucDwguonyIOqMOmjy8sW0rQAMzTYdMxIUrksC4yYjA4v
        Hw+Py/YWjyOBJWD4IcfJlgnGarIYZA5oxW3k/kvrAsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=DWpYJH
        Z7C02OmWS9zpShdVrwGV4F/Bj3lGFh/gah9uo=; b=F2ZlyobFkCLZ3UNk2B9Suj
        VNv/Iti2/QjKhW2dcThhWgroS/CDx0+Z3W96LFPXkr4ISYrD5MHMGb03Ak0mb1UK
        71YfP0F6Id63ZLo96yt672o2Gj23kCO+B5jW2v5+tdOB6NSYV9WmSMbRsNfzJviI
        +0Lwk6BM/vIqaoMTMcoL88u1gXzr/bqHg0yzttd7/O6NtaLW3iHt7hCKnCRXM2z+
        sCeVegzBh5sj+8+eOCFshui6oNwHhGhatTYZ9Ju2gnQ/j5eRdLTU1oUHzW6uhn5o
        j4JnWyAUA5vro61035S+R6wo5Dv4zygR9ynFk4kdt8SDJO28B1iHKoJzgR014jsg
        ==
X-ME-Sender: <xms:4AmeYeooQFTMaa7ee2y-eUsGlvXhiRXOhD-c2RQTGPpmpcJY8rmDWg>
    <xme:4AmeYcrDwW_C8cPnxaeMyiCzAl02yRnvbz5FKCdG1YWeGBsEwBnpH_ORa-SyllsRe
    j35Sosnl1Y0Zw>
X-ME-Received: <xmr:4AmeYTMxAE2f37Sw42Js7XFg1MJQJNOtkjfi7J_04nkMxui1GyTGrxksgWrkypKNBp4-u84IA3rM5qHTC5vJWsEtnBDdXDbL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrgeekgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeen
    ucggtffrrghtthgvrhhnpeevueehjefgfffgiedvudekvdektdelleelgefhleejieeuge
    egveeuuddukedvteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:4AmeYd4wMM8o2GnZHPt5ClW7-6os7OaiJFHW9VZLWFTGFAI4_7rcnA>
    <xmx:4AmeYd4GWFARZsEBwOVBBD4lOw44WQGQEFkR4brDehpffpcKDD4fZA>
    <xmx:4AmeYdj8NKXSqVlPZqu9PQyjChXsv52nC_-UrRPpdGg59GTPCPXRkQ>
    <xmx:4AmeYRor4XEzO6NCFMSghgx2_RyR1LnJcM3rBkytgjdLCTahLEa6Zw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Nov 2021 04:46:07 -0500 (EST)
Date:   Wed, 24 Nov 2021 10:46:03 +0100
From:   Greg KH <greg@kroah.com>
To:     cgel.zte@gmail.com
Cc:     pbonzini@redhat.com, shuah@kernel.org, deng.changcheng@zte.com.cn,
        mlevitsk@redhat.com, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] KVM: selftests: use ARRAY_SIZE
Message-ID: <YZ4J23oFTTDpjSa8@kroah.com>
References: <20211124092256.37966-1-deng.changcheng@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124092256.37966-1-deng.changcheng@zte.com.cn>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 24, 2021 at 09:22:56AM +0000, cgel.zte@gmail.com wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> Use ARRAY_SIZE instead of dividing sizeof array with sizeof an element.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>

Your email address does not match these here, you need to provide a
signed-off-by as well.

And are you _SURE_ that you can use kernel #defines in userspace testing
code?

thanks,

greg k-h
