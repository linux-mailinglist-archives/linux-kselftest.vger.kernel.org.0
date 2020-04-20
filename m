Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079331B08F9
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Apr 2020 14:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgDTMMT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Apr 2020 08:12:19 -0400
Received: from mout.web.de ([217.72.192.78]:36739 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbgDTMMS (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Apr 2020 08:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1587384726;
        bh=tDAkkNNCVUcBG1Pd0UfhpAWb1rA0zBNXJfnJVLemo3g=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=j3T5v/x8V52w94ZbFqw5ZvAUF2QS9vxWQ6bl1w+NlRYIxcdVy7nIf4PbZw6UIueWY
         TjTrnIeZVbiG4BrzS/TTueBFrrLMULAY4TFMt1Mcbz89s1B1PQ/M5FXOc9vpc88HND
         Xxw9p9/HsV9xKACEyV7GEn5jfMTr46er092h1Crg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.153.203]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0ML8Kj-1jQEAJ1DBh-000P6C; Mon, 20
 Apr 2020 14:12:06 +0200
Subject: Re: [v2 1/4] selftests: kmod: Subsequent patch series with cover
 letters?
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        linux-kselftest@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        linux-kernel@vger.kernel.org
References: <1587381782-31047-1-git-send-email-yangtiezhu@loongson.cn>
 <ff9ef06c-0607-8b8e-b80d-6a531921a67e@web.de>
 <ac7bd076-8fb2-6d8b-655c-98ea7e7d2a4d@loongson.cn>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <716aa410-dd2f-f8d0-b3b6-5f26b42990dc@web.de>
Date:   Mon, 20 Apr 2020 14:12:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ac7bd076-8fb2-6d8b-655c-98ea7e7d2a4d@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:13Hd0P4rY8VETV0ITG/jemyOnDD4Jmat9ajpsiAutFHDqqu18wj
 +2z6qpQf39gNNA8W9KAX6QMNFj5RBiA6vs04aAfDuZl0z/L6Fk5jjlIisnTu0/6i9aTxk7B
 6TA0YKqOWGR/57d7y1RqG0dyjata7gEamMHjt7CCBxDfiR+gyxVmtIF00OIZCVlB/hQMKtm
 ORc5oKzW/m+N6m/SHODDA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GxChLAXsGTc=:/vDZdlGAR/UWA6g0kBj233
 KAA/+ucp/g5paoFd43SVDVQNSU2l55OxFHHLwH5wz/HE3QgR+8MMAtL63KAyYboh+cO0yAtFR
 adpf27isE9JAArs0EbhADbextiv/AtdWlJOB6PUG/ius3MujoCVQpvZO8Vqu1DuFYLWKFCqEE
 XYAkSu3bEEappRjtIoeSGkAEbFOUdPioY7mlIujE9hbiMhCqY74kmviKVJg+DN9EBY1okDkb/
 NadmnXGF8QdcwZ4dbRY21tslCoZzMprlbTGCSkkvCZdyADdFjZf4DrVi81Jf44d7jvvwi8c2G
 0uwNzfukJ2eRV6Q8meLVR/eBVbA8aH6aFJNkVXdPdIvuTvT2pdwsN14W24YdGvQ7HxBmPDRGo
 P46em/+MU86DJfQbfScUXf3jmLuLlfgSR85cQwWOpJiiH74/lcMK7T/jNeO71hQV1jLxhG0Jk
 MGNewlQF1sFQ5x57LTgAxiFFDgM666El/72HWT9LOsZUkxiL4yywexAEA7GHEO2weVgLt75G7
 lWownsEMwZAdWUBPnVyMWb9NtVtYX7AuerIxxZS+JA+zDoH1zvMEfs5SeRYYpGly5t8SgGfSh
 pPSzwcQ0aQHsUjvMJIFiOvQ6ag/wFb8/EC9MlX89015lfxpm6+fKFDsV7BEFWCKNkKAecirI8
 JNxQAhx5XOP0zPnEbxzVW2IseVVFjTpS5QVaIC0Jk9KPg/xIcQlx0wCEJuA+dvGIQ90hl/p7y
 Hu41T2yoHuTEoeef5yLNjP0V7pdAw07DuoetVvsm5kCNECeol7Uqq3U8EpF/m7mZfK8U5OtiM
 AnwHPcG+/lNA7t5h/uAQcURPX6Pn28ERmjA9NEwMW5E+U5PjoD2sxPf1DkGn9yWfzbffgbyNw
 dibRHbozeYkc9A6BSBMyiRQjxY0m9uuUzvWWlKM2km5VrFHKIIWEbT4H3KNOnnb+IWe0g/rp9
 ds79dHMrPg5/EqaP/qnYz0522AnlbvBYaM8mb51Moxime9Vnrws9CgsU4N3otBPiSsupA67OQ
 P4jw45HUsUAAhivATz0Lhm5h9lTVio9tHrqxvReI/vkuAvUDk7XjPGJREUfl0CWpp1GSKEMjb
 HPa1PWlOQ4zhVb8Qw4pw7DUjd5kLW25l5WE+260/vO1RllPiqwATgZ1hqll9Mb+bCpoQ0FGzb
 b5bbci2zuYWGLcbreOYlepxVmRinQHW7mdHOAenmveXRmqPiC12OwyZ0qIAZGViRzXDbw8Rk+
 KHF+ydw4tOwM8mfyh
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> OK, thanks for your suggestion.

Thanks for your acceptance.


> I will resend it with a cover letter.

I guess that such a resend would be needed only
if another version for this patch series will be published.
It seems that the attention can occasionally grow also for
the usage of helpful cover letters.

Regards,
Markus
