Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5ABB6C973F
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Mar 2023 19:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjCZRjX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 26 Mar 2023 13:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjCZRjW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 26 Mar 2023 13:39:22 -0400
X-Greylist: delayed 1339 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 26 Mar 2023 10:39:21 PDT
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6698355AD
        for <linux-kselftest@vger.kernel.org>; Sun, 26 Mar 2023 10:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=TtKgtk9kregiWGn+VAskA/UgDBK371iiirhB/FRAS84=; b=WIjafrfM0VhCtg0Rftxur3EcIi
        33eOaJfGUoR3z9Zg/YPms7LmoijJJL2LOb0baTMBgzNlAGctC6cWCvZ7s8Bo6WHBWQsNG2wXcsBFw
        5CtFFszNX7jdn+uzWqvcwIFKZz78bzRt4pF2aLVRHluM3Lh/adQoPYnYv4tPLLwVZ5BU1yE0mFKQI
        2o7mSlO4i07it4BXSYaGgs4n9am9gitqPd2zC5pNp8rLBpsghjLcJYWupr3QSLCvIKLcbFk1kiA7A
        IRAjIkMpYy2W8ANK6poc9KRzctnd7DB73pblSQI0iwNMDLWNEceMsEYamRKc0WP9N4VOb+vB2156L
        WsOEQYrg==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1pgTzH-000NaI-03; Sun, 26 Mar 2023 19:16:59 +0200
Received: from [2604:5500:c0e5:eb00:da5e:d3ff:feff:933b]
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1pgTzG-000Foh-Cf; Sun, 26 Mar 2023 19:16:58 +0200
Message-ID: <d9d4894e-d386-dba5-3e6a-c48c5d143e45@metafoo.de>
Date:   Sun, 26 Mar 2023 10:16:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v5 1/8] drivers: kunit: Generic helpers for test device
 creation
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, Stephen Boyd <sboyd@kernel.org>,
        linux-iio@vger.kernel.org
References: <ZBrvhfX/NNrJefgt@kroah.com>
 <25f9758f-0010-0181-742a-b18a344110cf@gmail.com> <ZBtPhoelZo4U5jwC@kroah.com>
 <20230323101216.w56kz3rudlj23vab@houat> <ZBwoRgc2ICBJX/Lq@kroah.com>
 <8a03a6fb-39b9-cd17-cc10-ece71111357d@gmail.com>
 <20230323122925.kqdnomr7i46qnyo4@houat>
 <590189b3-42d9-ab12-fccd-37338595cb6f@gmail.com>
 <20230323163639.xtwpid2uunwnzai4@houat>
 <a0e8b1da-3645-4141-6518-e035ad80a23d@gmail.com>
 <20230324123157.bbwvfq4gsxnlnfwb@houat>
 <20230325175044.7bee9e7d@jic23-huawei>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20230325175044.7bee9e7d@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.8/26855/Sun Mar 26 09:23:02 2023)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/25/23 10:50, Jonathan Cameron wrote:
> On Fri, 24 Mar 2023 13:31:57 +0100
> Maxime Ripard <maxime@cerno.tech> wrote:
>
>> On Fri, Mar 24, 2023 at 08:11:52AM +0200, Matti Vaittinen wrote:
>>> On 3/23/23 18:36, Maxime Ripard wrote:
>>>> On Thu, Mar 23, 2023 at 03:02:03PM +0200, Matti Vaittinen wrote:
>>>>> On 3/23/23 14:29, Maxime Ripard wrote:
>>>>>> On Thu, Mar 23, 2023 at 02:16:52PM +0200, Matti Vaittinen wrote:
>>>>>>
>>>>>> This is the description of what was happening:
>>>>>> https://lore.kernel.org/dri-devel/20221117165311.vovrc7usy4efiytl@houat/
>>>>> Thanks Maxime. Do I read this correcty. The devm_ unwinding not being done
>>>>> when root_device_register() is used is not because root_device_unregister()
>>>>> would not trigger the unwinding - but rather because DRM code on top of this
>>>>> device keeps the refcount increased?
>>>> There's a difference of behaviour between a root_device and any device
>>>> with a bus: the root_device will only release the devm resources when
>>>> it's freed (in device_release), but a bus device will also do it in
>>>> device_del (through bus_remove_device() -> device_release_driver() ->
>>>> device_release_driver_internal() -> __device_release_driver() ->
>>>> device_unbind_cleanup(), which are skipped (in multiple places) if
>>>> there's no bus and no driver attached to the device).
>>>>
>>>> It does affect DRM, but I'm pretty sure it will affect any framework
>>>> that deals with device hotplugging by deferring the framework structure
>>>> until the last (userspace) user closes its file descriptor. So I'd
>>>> assume that v4l2 and cec at least are also affected, and most likely
>>>> others.
>>> Thanks for the explanation and patience :)
>>>    
>>>>    
>>>>> If this is the case, then it sounds like a DRM specific issue to me.
>>>> I mean, I guess. One could also argue that it's because IIO doesn't
>>>> properly deal with hotplugging.
>>> I must say I haven't been testing the IIO registration API. I've only tested
>>> the helper API which is not backed up by any "IIO device". (This is fine for
>>> the helper because it must by design be cleaned-up only after the
>>> IIO-deregistration).
>>>
>>> After your explanation here, I am not convinced IIO wouldn't see the same
>>> issue if I was testing the devm_iio_device_alloc() & co.
>> It depends really. The issue DRM is trying to solve is that, when a
>> device is gone, some application might still have an open FD and could
>> still poke into the kernel, while all the resources would have been
>> free'd if it was using devm.
>>
>> So everything is kept around until the last fd is closed, so you still
>> have a reference to the device (even though it's been removed from its
>> bus) until that time.
>>
>> It could be possible that IIO just doesn't handle that case at all. I
>> guess most of the devices aren't hotpluggable, and there's not much to
>> interact with from a userspace PoV iirc, so it might be why.
> Lars-Peter Clausen (IIRC) fixed up the IIO handling of the similar cases a
> long time ago now. It's simpler that for some other subsystems as we don't
> have as many interdependencies as occur in DRM etc.
>
> I 'think' we are fine in general with the IIO approach to this (I think we
> did have one report of a theoretical race condition in the remove path that
> was never fully addressed).
>
> For IIO we also have fds that can be open but all accesses to them are proxied
> through the IIO core and one of the things iio_device_unregister() or the devm
> equivalent does is to set indio_dev->info = NULL  (+ wake up anyone waiting on
> data etc). Alongside removing the callbacks, that is also used as a flag
> to indicate the device has gone.
>
> Note that we keep a reference to the struct indio_dev->dev (rather that the
> underlying device) so that is not freed until the last fd is closed.
> Thus, although devm unwinding has occurred that doesn't mean all the data
> that was allocated with devm_xx calls is cleared up immediately.

IIO is fully hot-plug and hot-unplug capable. And it will have the same 
issue. When using managed device registration that establishes a parent 
child relationship between the devices and in combination with a device 
where the managed unwinding does not happen on unbind, but rather on in 
the release callback you create a cyclic reference dependency. The child 
device holds a reference to the parent, but the reference is only 
released in the parents release callback. And since that release 
callback is not called until the last reference is dropped you end up 
with a resource leak.

There are even some other places where IIO drivers run into this. E.g. 
any driver that does `devm_iio_trigger_register(&indio_dev->dev, ...)` 
creates a resource leak on the trigger and the IIO device. The indio_dev 
is not a bus device, hence no unbind and the trigger holds a reference 
so the release callback will never be called either.

