Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BE47860B5
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Aug 2023 21:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238307AbjHWTgV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Aug 2023 15:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238305AbjHWTfy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Aug 2023 15:35:54 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B59E5F;
        Wed, 23 Aug 2023 12:35:53 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fef34c33d6so29078865e9.3;
        Wed, 23 Aug 2023 12:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692819351; x=1693424151;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bp6bqfxHSQpdkJRolDmXvKb/3Pn3dAeE7ceDWHWRWDA=;
        b=Pz5GxaNuZRWinCrudpRM+C6sPFDBxK+ivZHBISs3ftAuYHWoN/CiGfoZc3wneRFyzr
         YOE35feW/4E6p/qBo5AoobnPCdphf3sLAR3NhBjOVkSc/7lGfk4AvZo+l3ZGeqELWAua
         dXi2R9F+coHLxhqBXa8ijVNVaNr1REcetkiGtSue7Djan5z7k2M1N0NjITTzPEtZmBLv
         a1OUCSn4uGpnx16Pe+edGOSJWNbUSTF4swUW9sMK2jV6ecXzu9om6ZR+uaoL/C5OIFg4
         CQD7XievlNqaf42X8hksPc6AzRdhOQHaSXG8iByc0qI6mVQnri+yg0KPkdO3u37L+VIG
         L/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692819351; x=1693424151;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bp6bqfxHSQpdkJRolDmXvKb/3Pn3dAeE7ceDWHWRWDA=;
        b=K0Jf1jgiim+MuZL5eJ/Z18KElHd6DCH2RpsVKff9UJvG+dvu0d+g/TJMCnVdCCP/26
         wAgVdI1u+uf/8ba+JmBGpoAd2nNa4zgKKJsNexJlFrKOhNiU+CGn5Uf8ph5FnYhbWt4x
         1hnt0CxHPIzkoTnH/+AK6mbQYt6XhFoiVuJjyluqJk4QyyLS6AjF9OMbGelrIn5d/WBi
         /HBODeO+1glgKzQX8iyR6fuCiTmHtzzS0CS1qRc+Qx5lDAoYYhisN6VOkZojzNlzk+Cw
         /VYL2nYS0hUn1qP0wQDCldOXRKliFvQ24/63zYZ43vmPkxKoG/n9Yqg3KO6oQsyGUq4x
         ohTQ==
X-Gm-Message-State: AOJu0YyEuUsnMLgkELVp3dCvac5oReJ6u3GrzJweCYfCy8L62xaw3hiJ
        5XuLv3v0vis8BD/plP0kOZZ6YkgZ1JaQMg==
X-Google-Smtp-Source: AGHT+IE/pM8ndpJGoLUlBS3tuaqhUZ8RbNcGhFz69gcMjVcaQK1oUzA23JffSfe6yWFdi+iqNFaCAg==
X-Received: by 2002:adf:f3cd:0:b0:319:6ce2:e5a3 with SMTP id g13-20020adff3cd000000b003196ce2e5a3mr10674485wrp.26.1692819351220;
        Wed, 23 Aug 2023 12:35:51 -0700 (PDT)
Received: from mmaatuq-HP-Laptop-15-dy2xxx ([2001:8f8:1163:806e:99f3:c946:a43c:e1e3])
        by smtp.gmail.com with ESMTPSA id p6-20020a5d68c6000000b00317f70240afsm20336320wrw.27.2023.08.23.12.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 12:35:50 -0700 (PDT)
Date:   Wed, 23 Aug 2023 23:35:45 +0400
From:   Mahmoud Matook <mahmoudmatook.mm@gmail.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Willem de Bruijn' <willemdebruijn.kernel@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Subject: Re: [PATCH 1/2] selftests: Provide local define of min() and max()
Message-ID: <20230823193545.nrzlbsa32hm4os4k@mmaatuq-HP-Laptop-15-dy2xxx>
Mail-Followup-To: David Laight <David.Laight@ACULAB.COM>,
        'Willem de Bruijn' <willemdebruijn.kernel@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org" <linux-kernel-mentees@lists.linuxfoundation.org>
References: <20230819195005.99387-1-mahmoudmatook.mm@gmail.com>
 <20230819195005.99387-2-mahmoudmatook.mm@gmail.com>
 <64e22df53d1e6_3580162945b@willemb.c.googlers.com.notmuch>
 <7e8c2597c71647f38cd4672cbef53a66@AcuMS.aculab.com>
 <CAF=yD-+6cWTiDgpsu=hUV+OvzDFRaT2ZUmtQo9qTrCB9i-+7ng@mail.gmail.com>
 <d33fbb24119c4d09864e79ea9dfbb881@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d33fbb24119c4d09864e79ea9dfbb881@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 08/22, David Laight wrote:

> ...
> > > That typecheck() is horrid.
> > > It may well have caused more bugs due to incorrect casts that
> > > it actually detected.
> > >
> > > I'd suggest the version that just avoids multiple evaluations.
> > > Or just error signed v unsigned comparisons.
> > > See  https://lore.kernel.org/all/b4ce9dad748e489f9314a2dc95615033@AcuMS.aculab.com/
> > > for an example patch set.
> > 
> > Interesting, thanks. That is also simpler.
> > 
> > Also, the existing patch is no worse than the open coded code today,
> > so even without code to avoid multiple evaluations, I guess it's okay
> > to merge.
> > 
> > The coccinelle warnings are arguably false positives, using checks for
> > kernel code, but being run against userspace code that has no access
> > to those helpers. But fine to silence them.
> 
> You can't use is_constexpr() unless 'sizeof *(void *)' is valid.
> And builtin_constant() isn't good enough for builtin_choose_expr().
> 
> That might be ok for selftests and tools, but not for generaluserspace.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
I tried to use the relaxed version provided in the shared patchset link 
besides not able to use is_constexpr(), I'm not able to use
__UNIQUE_ID() also. It's definded inside include/linux/compiler-gcc.h
and it uses another macro __PASTE() which is defined inside
include/linux/compiler_types.h. 
not sure what to do next
- bring those macros definitions to able to use the relaxed version.
- if the most important point for min/max defines inside selftests is to
  avoid multiple evaluation is the below version acceptable?
  /*
  #define min(x, y) ({ \
    typeof(x) _x = (x); \
    typeof(y) _y = (y); \
    _x < _y ? _x : _y; \
})

#define max(x, y) ({ \
    typeof(x) _x = (x); \
    typeof(y) _y = (y); \
    _x > _y ? _x : _y; \
})
*/
