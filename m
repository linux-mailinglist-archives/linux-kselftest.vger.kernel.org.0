Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8105019A4
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Apr 2022 19:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239274AbiDNRKY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Apr 2022 13:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344447AbiDNRIe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Apr 2022 13:08:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCA6658D;
        Thu, 14 Apr 2022 09:56:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC2E9B82AE7;
        Thu, 14 Apr 2022 16:56:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6CFC385A5;
        Thu, 14 Apr 2022 16:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649955410;
        bh=aLd6aWSBkha/oKsu6yaDD5kcf+X2TOIiW+ngxqC0ZzA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VFD3QPGeA3kr2TGkSpwktjoWVBKdxkte8J60mYowuZQFigLOfaB5VibSbWwRQeW4x
         vvUyDwHs6asVNdZOem6WvGsIXgDLw9fXr+H0O6A8ru43ToiGWQkPPPExRTE2+YEucw
         sZZbbW1gZMzbn+kBJCPcXLyftq1LJ3dvFrQhS6JqGvo+fZcP+10Ch7xNx8kuSSutBo
         HArrsCDNPpUvJXU0W4VvXelBLGxKzvG55/cnjTvYsb24yu1FXHV6jbeTHLHPLl7V/y
         XPNxa9a8HYAnF8+nQMMc+eUm6UH5mPSwQAEHLQPm9hgiTnm0mLB8kju86DVU2JpKDa
         THnoLsLzmrY7Q==
Message-ID: <42a52a6018e8dadb4c3eebefaae4dab31c0d5721.camel@kernel.org>
Subject: Re: [PATCH V4 00/31] x86/sgx and selftests/sgx: Support SGX2
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, vijay.dhanraj@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Date:   Thu, 14 Apr 2022 19:55:42 +0300
In-Reply-To: <9fbf26c8-5808-20c5-8653-d4f36bf398a4@intel.com>
References: <cover.1649878359.git.reinette.chatre@intel.com>
         <2f4338f37943c2b067db16ae65c9af665d3b51d9.camel@kernel.org>
         <9fbf26c8-5808-20c5-8653-d4f36bf398a4@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2022-04-14 at 09:34 -0700, Reinette Chatre wrote:
> Hi Jarkko,
>=20
> On 4/14/2022 4:25 AM, Jarkko Sakkinen wrote:
> > On Wed, 2022-04-13 at 14:10 -0700, Reinette Chatre wrote:
> > IMHO, we can pull this after +1 version. I think I had only one nit
> > (one character to a struct name it was), and I've been testing this
> > series *extensively* with real-world code (wasm run-time that we are
> > developing), so I'm confident that=C2=A0 it is *good enough*.
>=20
> Thank you very much. I am aware of other teams successfully building
> on and testing this work. I do hope that they could also provide an
> ack to help increase the confidence in this work.
>=20
> >=20
> > Reinette, for the EMODT patch, as long as you fix the struct name
> > you can add my reviewed-by and also tested-by to that patch before
> > you send it! It's so narrow change.
>=20
> Thank you. I will make the struct name change and also plan to
> make the same change to the function names in that patch to ensure that
> everything is consistent in that regard.=20

I think getting ack from anyone working Graphene-SGX would bring
a great coverage of different use cases. It's different same of
Enarx in the sense that both can run arbitrary applicatons written
e.g. with C++ although approaches are on opposite sides.

> Reinette

BR; Jarkko
