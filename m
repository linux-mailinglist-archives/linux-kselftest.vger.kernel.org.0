Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5895E7FF0
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2019 06:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbfJ2FxX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Oct 2019 01:53:23 -0400
Received: from smtp3-1.goneo.de ([85.220.129.38]:49373 "EHLO smtp3-1.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbfJ2FxX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Oct 2019 01:53:23 -0400
X-Greylist: delayed 629 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Oct 2019 01:53:20 EDT
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id 1EC9B24007F;
        Tue, 29 Oct 2019 06:42:49 +0100 (CET)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.747
X-Spam-Level: 
X-Spam-Status: No, score=-2.747 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=0.153, BAYES_00=-1.9] autolearn=ham
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qZjqyjNzm7GN; Tue, 29 Oct 2019 06:42:47 +0100 (CET)
Received: from [192.168.1.103] (dyndsl-037-138-239-146.ewe-ip-backbone.de [37.138.239.146])
        by smtp3.goneo.de (Postfix) with ESMTPSA id 024AA23F854;
        Tue, 29 Oct 2019 06:42:46 +0100 (CET)
Subject: Re: [PATCH v2] kernel-doc: rename the kernel-doc directive
 'functions' to 'identifiers'
To:     Changbin Du <changbin.du@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-crypto@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-usb@vger.kernel.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
References: <20191020131717.28990-1-changbin.du@gmail.com>
 <20191024121940.1d6a64df@lwn.net> <87woctb9cj.fsf@intel.com>
 <20191025144802.uixg2crhw6h7gghq@mail.google.com> <87v9s99q9l.fsf@intel.com>
 <20191029003120.llve32crfw63ovpw@mail.google.com>
From:   Markus Heiser <markus.heiser@darmarit.de>
Message-ID: <36c4dcfb-5425-b4bc-a5e9-4fd1458c8385@darmarit.de>
Date:   Tue, 29 Oct 2019 06:42:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191029003120.llve32crfw63ovpw@mail.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Am 29.10.19 um 01:31 schrieb Changbin Du:
>> But is it, really? I agree with Jon about the distinction between None
>> and '' being confusing.
>>
> Here python is different from C. Both empty string and None are False in python.
> Note such condition is common in python.

The one is a empty string str(''), its bool('') value is False.

| >>> type(''), bool('')
| (<class 'str'>, False)

The other is a NoneType, its bool(None) value is False.

| >>> type(None), bool(None)
| (<class 'NoneType'>, False)

None often used like NULL (pointer). E.g if a function does not give an explicit 
return value, the returned value is None.

| >>> def foo():
| ...     pass
| ...
| >>> print(foo())
| None


-- Markus --

