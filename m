Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854E0702C71
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 May 2023 14:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjEOMOf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 08:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236891AbjEOMOV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 08:14:21 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5106E55;
        Mon, 15 May 2023 05:14:09 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 11DD55C0109;
        Mon, 15 May 2023 08:14:09 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 15 May 2023 08:14:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1684152849; x=1684239249; bh=V3
        w21LLB6kjaFa2uDlyQzaBQt+wBaW+MSdWQWfRjAd0=; b=AyVHcuGraGGGQsduag
        pUh+ancekxxs1USnn7U5Rla1/1/LpAkIkPU84Q3PLFbfOI6wxgRf/pGiub5gCN1q
        GQAJPySpYJI6Vj//gI25dU+TFxxztGNbb2Soa74Oonq209z590WOi0QD1JUFVM9U
        E3ITJTmvzb3OezoAXpFhQFrA0vaxXjEM3Irg2u6PS9B1/9mrE0wd4C+pwdZDpUTa
        bYcRbk20gCoNV58NdYaeIekXegmyEdwyytELbQcUDORUnyEMHeAyFpvrFNOXaMx4
        cT9QGiyfgrVUSSIV5CwUgPx9oewBimYgmAIhxbu8cuUNuU8FCOncIqd9use/7P0E
        kWiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684152849; x=1684239249; bh=V3w21LLB6kjaF
        a2uDlyQzaBQt+wBaW+MSdWQWfRjAd0=; b=VzbFarfI3Sgyr+si1Y8l2eV3GePk5
        wcgKuJSmgMU4WCwx1H5jJE3nPWKjS0Wo6nsSSO6uUIbs1ujKbOibD9+B65Yyiuhi
        JJdFZt33WH4VGMDciyPNbcpivd99NHqyzUaqz1InPzAcp98EJUW+1QqkrsH75TGK
        jwGvVotSpgZBQC6/Lua0cuma6ZzLFKuVb/1jR7guq3FMjCU/l7DRhhzKLpkmBjnu
        73nNXhMqgyZkJ0eOsQLPnldBJKyDYxvFaYLDZakzQsN07LZP5bFJCyPAOBSIXf0k
        3xmBkCd2velMmOuGP7eHEKZDvAfmZ0tu7Hk1hJdZwYsIj0FcHltsgf+OA==
X-ME-Sender: <xms:ECJiZAcqVAszf64cJoeWFgCs3T66Dleo93NBKuGk8TUzGAqALvHRXg>
    <xme:ECJiZCNLAomicbTbk5zcEQXhv6kKbs3PLoQtKced6Ep8RXIdJOgcm24x3VXXclHIF
    FpvNJXNVWEZZBnKqpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehjedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:ECJiZBjIH_upqE2cmh3gNhSGkeBf8NkZCjkEhfzRraVo5n7oAkxb4g>
    <xmx:ECJiZF8uUQUUvuagIv2H0q_zp7JtWfF7wgooQx7PjmdbKIK0LfLTNw>
    <xmx:ECJiZMvcEZHQps_W7DXjumlMq0nchohvu_1zTGGLNqD1fiPkzua9gA>
    <xmx:ESJiZKDmMOV1WrBAX6kOzkXODQHCioVwAVTfrWpFlQW3zEpypbJNZg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BF91FB60089; Mon, 15 May 2023 08:14:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-415-gf2b17fe6c3-fm-20230503.001-gf2b17fe6
Mime-Version: 1.0
Message-Id: <3696666f-9b48-405c-a715-8adf927fd86e@app.fastmail.com>
In-Reply-To: <a9e9a1a7-346a-475e-961c-ec8568613b45@kili.mountain>
References: <CA+G9fYuoB8Ug8PcTU-YGmemL7_eeEksXFihvxWF6OikD7sK7pA@mail.gmail.com>
 <a9e9a1a7-346a-475e-961c-ec8568613b45@kili.mountain>
Date:   Mon, 15 May 2023 14:13:28 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Dan Carpenter" <dan.carpenter@linaro.org>,
        "Naresh Kamboju" <naresh.kamboju@linaro.org>,
        =?UTF-8?Q?Ricardo_Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
Cc:     "open list" <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Ard Biesheuvel" <ardb@kernel.org>, shuah <shuah@kernel.org>,
        "Anders Roxell" <anders.roxell@linaro.org>
Subject: Re: selftests: mincore: mincore_selftest fails only on qemu-armv7
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, May 15, 2023, at 13:51, Dan Carpenter wrote:
> On Mon, May 15, 2023 at 03:29:02PM +0530, Naresh Kamboju wrote:
>> The selftests: mincore: mincore_selftest fails only on qemu-armv7 running
>
> tools/testing/selftests/mincore/mincore_selftest.c
>    139  TEST(check_huge_pages)
>    140  {
>    141          unsigned char vec[1];
>    142          char *addr;
>    143          int retval;
>    144          int page_size;
>    145  
>    146          page_size = sysconf(_SC_PAGESIZE);
>    147  
>    148          errno = 0;
>    149          addr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
>    150                  MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
>    151                  -1, 0);
>    152          if (addr == MAP_FAILED) {
>    153                  if (errno == ENOMEM)
>
> On Armv7 is a 32bit machine so HUGETLB isn't enabled and the errno can
> be -EINVAL.  It's has returned this for 10 years.

I expected it to be enabled on 32-bit as well, but I see that
on normal ARMv7 without CONFIG_ARM_LPAE, it is indeed
always turned off, and the asm/pgtable-2level.h does not
define a way to use sections or supersections in user space:

arch/arm/Kconfig:       select ARCH_SUPPORTS_HUGETLBFS if ARM_LPAE

      Arnd
