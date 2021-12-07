Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C53846AEEF
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Dec 2021 01:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350963AbhLGAYU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Dec 2021 19:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348536AbhLGAYT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Dec 2021 19:24:19 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D0FC061746;
        Mon,  6 Dec 2021 16:20:50 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id gt5so9003888pjb.1;
        Mon, 06 Dec 2021 16:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WqSTDjAHEVn42wztnl97tEnW1h1W5PS0PVgwPP4nQxE=;
        b=iiRTUEdd+nsFk+Rol/TzBTrRtRIiW2YnsjYFMv5FHqei1HK+KtafllVrNw5FtonQxL
         B5w55ppXzh9aGF0h22o5G8lppy+0EIj1fiFHhJ7B2NUksfJ+0lF8vA57WlFk9s6ahfQh
         wQFCntoWV5AuX3eToVUl2Du0yWdlSKuSjnto5vMzzG+G0MyMB74phYrpZ1CdyubiJJcG
         ra+JzIuvOqfBJKA4EjtuWSzp+HvilM9brMLd9c9TEIuEJfkKsoGibOP4JmavBx10AphT
         lOUVgsSIS8f80BI6AaN36rkzUyqsdrTbVcqMqSSC31MV2Ne8sIvcGO/1YAiqnyyu7dDS
         cg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WqSTDjAHEVn42wztnl97tEnW1h1W5PS0PVgwPP4nQxE=;
        b=5lQYsB22oZl8JUjPNOQm/XAveu6BHz/KkKG1VXmM1GvFJZsKRJRpt6euJvzl0b1x5/
         I6neWGRwPPQCrv/8E0hEZ3coDEytRvBVui1nsplkdfDGyJpk+IT4X7svVLjeg7CwKAaM
         yJXTM8wJ0U+N8dllhY19vWsbV0IGGPGJKEXkx1mEryr6sDSSPUO3Tt2IWytHUtO2MsDS
         6VbQeNmWmCjOPaUMspCU93OOsgEe/g9EGEnhEn1xusxo35YrTyKP35hLiFTUNefugCMY
         LWlkP3H/v4TPepiGZReM53W4mc80b3TykJVteoua7kU4KpIZR2Cxi/nJfidxrzy6KMbc
         vvig==
X-Gm-Message-State: AOAM532+DDpf1j3Zye22u2DtbaIJmxH45hdBdiYnoJy74+XlWHzKycwv
        UvCrtcnHOutazZhqUPe+HZM=
X-Google-Smtp-Source: ABdhPJwRLpVAXP34ctC4r/CpQD2ExaU8sqBYXMlN8x194FT9PW3AprQuWjQY5XS1FKbEtpb4ut8aog==
X-Received: by 2002:a17:902:d28a:b0:142:61ce:ae4c with SMTP id t10-20020a170902d28a00b0014261ceae4cmr47270285plc.35.1638836450168;
        Mon, 06 Dec 2021 16:20:50 -0800 (PST)
Received: from postoffice.intern (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id o6sm13049741pfh.70.2021.12.06.16.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 16:20:49 -0800 (PST)
Date:   Tue, 7 Dec 2021 08:20:37 +0800
From:   David Yang <davidcomponentone@gmail.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     shuah@kernel.org, ptikhomirov@virtuozzo.com,
        christian.brauner@ubuntu.com, yang.guang5@zte.com.cn,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH v2] tests: remove unneeded conversion to bool
Message-ID: <Ya6o1Q4G3JGa5Pel@postoffice.intern>
References: <9bca1d9eb8ccacf4a64a8813f9eefe7f7272b3d6.1638581673.git.yang.guang5@zte.com.cn>
 <da6c119c-993b-dae5-25ff-e6cce97b55e3@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da6c119c-993b-dae5-25ff-e6cce97b55e3@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Thank you for your advice.

On Mon, Dec 06, 2021 at 12:03:06PM -0700, Shuah Khan wrote:
> On 12/5/21 5:07 PM, davidcomponentone@gmail.com wrote:
> > From: Yang Guang <yang.guang5@zte.com.cn>
> > 
> > The coccinelle report
> > ./tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c:225:18-23:
> > WARNING: conversion to bool not needed here
> > Relational and logical operators evaluate to bool,
> > explicit conversion is overly verbose and unneeded.
> > 
> > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
> > 
> > ---
> > 
> > Changes in v2:
> > - Change the return type to bool.
> > ---
> >   .../move_mount_set_group/move_mount_set_group_test.c   | 10 +++++-----
> >   1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c b/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
> > index 860198f83a53..50ed5d475dd1 100644
> > --- a/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
> > +++ b/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
> > @@ -191,7 +191,7 @@ static bool is_shared_mount(const char *path)
> >   #define SET_GROUP_FROM	"/tmp/move_mount_set_group_supported_from"
> >   #define SET_GROUP_TO	"/tmp/move_mount_set_group_supported_to"
> > -static int move_mount_set_group_supported(void)
> > +static bool move_mount_set_group_supported(void)
> >   {
> >   	int ret;
> > @@ -222,7 +222,7 @@ static int move_mount_set_group_supported(void)
> >   		      AT_FDCWD, SET_GROUP_TO, MOVE_MOUNT_SET_GROUP);
> >   	umount2("/tmp", MNT_DETACH);
> > -	return ret < 0 ? false : true;
> > +	return ret >= 0;
> >   }
> >   FIXTURE(move_mount_set_group) {
> > @@ -232,7 +232,7 @@ FIXTURE(move_mount_set_group) {
> >   FIXTURE_SETUP(move_mount_set_group)
> >   {
> > -	int ret;
> > +	bool ret;
> >   	ASSERT_EQ(prepare_unpriv_mountns(), 0);
> > @@ -254,7 +254,7 @@ FIXTURE_SETUP(move_mount_set_group)
> >   FIXTURE_TEARDOWN(move_mount_set_group)
> >   {
> > -	int ret;
> > +	bool ret;
> >   	ret = move_mount_set_group_supported();
> >   	ASSERT_GE(ret, 0);
> > @@ -348,7 +348,7 @@ TEST_F(move_mount_set_group, complex_sharing_copying)
> >   		.shared = false,
> >   	};
> >   	pid_t pid;
> > -	int ret;
> > +	bool ret;
> >   	ret = move_mount_set_group_supported();
> >   	ASSERT_GE(ret, 0);
> > 
> 
> Applied. In the future use selftests/<test>: .... convention for
> patch summary. Review "git log <filename>" history for how to
> write summaries and change logs.
> 
> I fixed this one for now.
> 
> thanks,
> -- Shuah
