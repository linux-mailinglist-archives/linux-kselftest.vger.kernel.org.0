Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE3110E42A
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2019 02:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfLBBSK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 1 Dec 2019 20:18:10 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:15009 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbfLBBSK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 1 Dec 2019 20:18:10 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191202011807epoutp0495e2e4714d261935b0924d801075f5fa~caRAGM8Bv2875128751epoutp04X
        for <linux-kselftest@vger.kernel.org>; Mon,  2 Dec 2019 01:18:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191202011807epoutp0495e2e4714d261935b0924d801075f5fa~caRAGM8Bv2875128751epoutp04X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575249487;
        bh=L1FiYkgREoa9V66jD4rXQx3Zgn2CIT1hecs6ORpJFdM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=AioP+2QhdApK+muPnmvAla/cLVvStWamnBUpfUCawG9QXhGcb3vW2Qz0FCOgcf06V
         Nd7lj2PdLtnKRUpGce86iSAEzye/xmv5vDPFcMc7KObdJu4hMqBu7y8IkAhpOV968y
         9c34lnStMbu/a6GVh4CB2YKiA1BlzLXa9AE1n9aI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191202011806epcas1p23b8e298797d5f5505dd980d252d3038c~caQ-LMNCt2750927509epcas1p2c;
        Mon,  2 Dec 2019 01:18:06 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.157]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47R6gH5DpNzMqYkc; Mon,  2 Dec
        2019 01:18:03 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        76.DD.48498.B4664ED5; Mon,  2 Dec 2019 10:18:03 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191202011803epcas1p4505bcccd88945750294466490fddbec0~caQ8XJGHH2920629206epcas1p49;
        Mon,  2 Dec 2019 01:18:03 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191202011802epsmtrp2f043bc7f6c9fe08411dc79eff11b29af~caQ7dI0TP2874528745epsmtrp2D;
        Mon,  2 Dec 2019 01:18:02 +0000 (GMT)
X-AuditID: b6c32a36-a55ff7000001bd72-35-5de4664bef03
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        31.71.06569.A4664ED5; Mon,  2 Dec 2019 10:18:02 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191202011801epsmtip239d9a848068e5aab7c7d1e4c159ecdd6~caQ7LCZ750353703537epsmtip2f;
        Mon,  2 Dec 2019 01:18:01 +0000 (GMT)
Subject: Re: [PATCH v4 0/4] PM / QoS: Restore DEV_PM_QOS_MIN/MAX_FREQUENCY
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Angus Ainslie <angus@akkea.ca>,
        Brendan Higgins <brendanhiggins@google.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <3a1f969f-87ff-8f98-9231-7bfe2b8106bf@samsung.com>
Date:   Mon, 2 Dec 2019 10:24:18 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB702392557AA56C0A49A463AAEE460@VI1PR04MB7023.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-2"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDJsWRmVeSWpSXmKPExsWy7bCmrq532pNYgwWtWhaHjm1lt3h8/zaj
        xcUbk5ktlszYyGZxtukNu8WKux9ZLbp+rWS2mH7nPZvF594jjBafNzxmtLjduILN4szpS6wW
        G796OPB6TO1awegxu+Eii8eCTaUeeyaeZPO4c20Pm8fGdzuYPA6+28PkseVqO4tH35ZVjB6f
        N8kFcEVl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYA
        3a6kUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKbAs0CtOzC0uzUvXS87PtTI0MDAy
        BSpMyM7Y9ukgS8F7w4pDu5cxNjDe1+pi5OSQEDCRuHlwCTuILSSwg1Fiy4owCPsTo8TM1vwu
        Ri4g+xujxP2f35hhGi6t+8wGkdjLKHF56zNmiI73jBK9W21BbGEBL4mp31rBikQE1jFK7Lk8
        gRXEYRY4zCzRv3cKI0gVm4CWxP4XN9hAbH4BRYmrPx6DxXkF7CTmPngEFmcRUJE4uvMYmC0q
        ECZxclsLVI2gxMmZT1hAbE6BWIm7a3aA/cAsoCfx7NQsFghbXOLWk/lMELa8xPa3c5hBjpAQ
        OMQusXrlTUaIf1wk1n/uZIWwhSVeHd/CDmFLSXx+t5cNwq6WWHnyCBtEcwcwkPZfgGowlti/
        dDIThK0osfP3XEaIbXwS7772ANVwAMV5JTrahCBKlCUuP7gLVS4psbi9k20Co9IsJP/MQvLD
        LCQ/zELywwJGllWMYqkFxbnpqcWGBUbI8b2JEZyytcx2MC4653OIUYCDUYmHt+PV41gh1sSy
        4srcQ4wSHMxKIrzXlR7GCvGmJFZWpRblxxeV5qQWH2I0BYb3RGYp0eR8YD7JK4k3NDUyNja2
        MDE0MzU0VBLn5fhxMVZIID2xJDU7NbUgtQimj4mDU6qB0bnzt7f66qQ6m6+n4vZm/lt8Ufl3
        blhL7dzQlrcn6+64m3NuVLV03+sVrrK+JryCqb+IryzO75NLQE7d3OIH/TLa36eyxy7WXhD+
        6OumDRcFr7y71VZw6OPhkHORNgdKZU+J5l8zdG14udFA+hr79Sd8K5b8ifsWr8usdPRbQdrM
        tUWbDQSOKbEUZyQaajEXFScCAA1qijvvAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsWy7bCSvK5X2pNYg5ePuS0OHdvKbvH4/m1G
        i4s3JjNbLJmxkc3ibNMbdosVdz+yWnT9WslsMf3OezaLz71HGC0+b3jMaHG7cQWbxZnTl1gt
        Nn71cOD1mNq1gtFjdsNFFo8Fm0o99kw8yeZx59oeNo+N73YweRx8t4fJY8vVdhaPvi2rGD0+
        b5IL4IrisklJzcksSy3St0vgytj26SBLwXvDikO7lzE2MN7X6mLk5JAQMJG4tO4zWxcjF4eQ
        wG5GibOTGtkhEpIS0y4eZe5i5ACyhSUOHy6GqHkLVHNoIhtIjbCAl8TUb61gzSICGxglTq5e
        yAziMAscZZbYcn4SE0RLI5PE32kLWUFa2AS0JPa/uAHWzi+gKHH1x2NGEJtXwE5i7oNHYHEW
        ARWJozuPgdmiAmESO5c8ZoKoEZQ4OfMJC4jNKRArcXfNDrBTmQV0JNo+L2SCsMUlbj2ZD2XL
        S2x/O4d5AqPwLCTts5C0zELSMgtJywJGllWMkqkFxbnpucWGBUZ5qeV6xYm5xaV56XrJ+bmb
        GMHRq6W1g/HEifhDjAIcjEo8vB2vHscKsSaWFVfmHmKU4GBWEuG9rvQwVog3JbGyKrUoP76o
        NCe1+BCjNAeLkjivfP6xSCGB9MSS1OzU1ILUIpgsEwenVANjnrDWv8evxPoXParWlmM2mlW1
        0+6Zx0Xlhmt75PzjmQ39H7yXEPz+1+aokUPspc/7A0SEnry61O7Lls3q9fT2bWa+mctYlnSV
        uTE/vvl/xa6JZ7l/zjHha/mo6tF5tLxhscnv97MtVimovZOZKLj/Nn+VqEbetMCqK1Fe/rdC
        tYLE9vFcae9RYinOSDTUYi4qTgQAUGKtndoCAAA=
X-CMS-MailID: 20191202011803epcas1p4505bcccd88945750294466490fddbec0
X-Msg-Generator: CA
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191129142101epcas5p4d512a1855d8307df769a147ace2942e3
References: <cover.1574781196.git.leonard.crestez@nxp.com>
        <3839981.6bSit4Rgby@kreacher>
        <CGME20191129142101epcas5p4d512a1855d8307df769a147ace2942e3@epcas5p4.samsung.com>
        <VI1PR04MB702392557AA56C0A49A463AAEE460@VI1PR04MB7023.eurprd04.prod.outlook.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/29/19 11:20 PM, Leonard Crestez wrote:
> On 2019-11-29 1:34 PM, Rafael J. Wysocki wrote:
>> On Tuesday, November 26, 2019 4:17:09 PM CET Leonard Crestez wrote:
>>> Support for frequency limits in dev_pm_qos was removed when cpufreq was
>>> switched to freq_qos, this series attempts to restore it by
>>> reimplementing on top of freq_qos.
>>>
>>> Discussion about removal is here:
>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-pm%2FVI1PR04MB7023DF47D046AEADB4E051EBEE680%40VI1PR04MB7023.eurprd04.prod.outlook.com%2FT%2F%23u&amp;data=02%7C01%7Cleonard.crestez%40nxp.com%7C4531c54354d54442d71808d774c02866%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637106240968746397&amp;sdata=LYIRtXYe8qPz1G%2F0ADYpPhbhviv1pkk7%2B%2BQ1dX1DQR8%3D&amp;reserved=0
>>>
>>> The cpufreq core switched away because it needs contraints at the level
>>> of a "cpufreq_policy" which cover multiple cpus so dev_pm_qos coupling
>>> to struct device was not useful. Cpufreq could only use dev_pm_qos by
>>> implementing an additional layer of aggregation anyway.
>>>
>>> However in the devfreq subsystem scaling is always performed on a per-device
>>> basis so dev_pm_qos is a very good match. Support for dev_pm_qos in devfreq
>>> core is here (latest version, no dependencies outside this series):
>>>
>>> 	https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.kernel.org%2Fcover%2F11252409%2F&amp;data=02%7C01%7Cleonard.crestez%40nxp.com%7C4531c54354d54442d71808d774c02866%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637106240968746397&amp;sdata=YodRx0IRVsjQXYA5X7UEosn%2FatO%2BWREfotwWrley2DQ%3D&amp;reserved=0
>>>
>>> That series is RFC mostly because it needs these PM core patches.
>>> Earlier versions got entangled in some locking cleanups but those are
>>> not strictly necessary to get dev_pm_qos functionality.
>>>
>>> In theory if freq_qos is extended to handle conflicting min/max values then
>>> this sharing would be valuable. Right now freq_qos just ties two unrelated
>>> pm_qos aggregations for min and max freq.
>>>
>>> ---
>>> This is implemented by embeding a freq_qos_request inside dev_pm_qos_request:
>>> the data field was already an union in order to deal with flag requests.
>>>
>>> The internal freq_qos_apply is exported so that it can be called from
>>> dev_pm_qos apply_constraints.
>>>
>>> The dev_pm_qos_constraints_destroy function has no obvious equivalent in
>>> freq_qos and the whole approach of "removing requests" is somewhat dubios:
>>> request objects should be owned by consumers and the list of qos requests
>>> will most likely be empty when the target device is deleted. Series follows
>>> current pattern for dev_pm_qos.
>>>
>>> First two patches can be applied separately.
>>>
>>> Changes since v3:
>>> * Fix s/QOS/QoS in patch 2 title
>>> * Improves comments in kunit test
>>> * Fix assertions after freq_qos_remove_request
>>> * Remove (c) from NXP copyright header
>>> * Wrap long lines in qos.c to be under 80 chars. This fixes checkpatch but the
>>> rule is already broken by code in the files.
>>> * Collect reviews
>>> Link to v3: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.kernel.org%2Fcover%2F11260627%2F&amp;data=02%7C01%7Cleonard.crestez%40nxp.com%7C4531c54354d54442d71808d774c02866%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637106240968746397&amp;sdata=e%2B5SGU%2Bx4UjxlY292ejMO1kDewc3MmFvCpf0SDB0K4U%3D&amp;reserved=0
>>>
>>> Changes since v2:
>>> * #define PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE FREQ_QOS_MAX_DEFAULT_VALUE
>>> * #define FREQ_QOS_MAX_DEFAULT_VALUE S32_MAX (in new patch)
>>> * Add initial kunit test for freq_qos, validating the MAX_DEFAULT_VALUE found
>>> by Matthias and another recent fix. Testing this should be easier!
>>> Link to v2: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.kernel.org%2Fcover%2F11250413%2F&amp;data=02%7C01%7Cleonard.crestez%40nxp.com%7C4531c54354d54442d71808d774c02866%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637106240968746397&amp;sdata=vyz%2FN2x7OZPCSx4Md8yQkOSjPtfNUvW6%2FHtG0bTG1xU%3D&amp;reserved=0
>>>
>>> Changes since v1:
>>> * Don't rename or EXPORT_SYMBOL_GPL the freq_qos_apply function; just
>>> drop the static marker.
>>> Link to v1: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.kernel.org%2Fcover%2F11212887%2F&amp;data=02%7C01%7Cleonard.crestez%40nxp.com%7C4531c54354d54442d71808d774c02866%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637106240968746397&amp;sdata=SjcSQmMRZu0z3ATWygBpD8mRToCZT%2FBgQ7U3IRpMUB0%3D&amp;reserved=0
>>>
>>> Leonard Crestez (4):
>>>    PM / QoS: Initial kunit test
>>>    PM / QoS: Redefine FREQ_QOS_MAX_DEFAULT_VALUE to S32_MAX
>>>    PM / QoS: Reorder pm_qos/freq_qos/dev_pm_qos structs
>>>    PM / QoS: Restore DEV_PM_QOS_MIN/MAX_FREQUENCY
>>>
>>>   drivers/base/Kconfig          |   4 ++
>>>   drivers/base/power/Makefile   |   1 +
>>>   drivers/base/power/qos-test.c | 117 ++++++++++++++++++++++++++++++++++
>>>   drivers/base/power/qos.c      |  73 +++++++++++++++++++--
>>>   include/linux/pm_qos.h        |  86 ++++++++++++++-----------
>>>   kernel/power/qos.c            |   4 +-
>>>   6 files changed, 242 insertions(+), 43 deletions(-)
>>>   create mode 100644 drivers/base/power/qos-test.c
>>>
>>>
>>
>> I have applied the whole series as 5.5 material, but I have reordered the fix
>> (patch [2/4]) before the rest of it and marked it for -stable.
> 
> Thanks!
> 
> Devfreq maintainers, do you think the devfreq parts could be queued for 
> 5.5 as well? I'm not sure about the mechanics involved in this since 
> devfreq qos depends at build time on this dev_pm_qos series.
> 
> Latest version is here: https://patchwork.kernel.org/cover/11252415/

Hi Leonard,

I agree devfreq's pm-qos patch.
[1] https://patchwork.kernel.org/cover/11252415/

But, I think need to discuss about this series[2].
Acutally, I don't want to split out the device_register.
[2]https://patchwork.kernel.org/cover/11242865/

> 
> It's RFC because it didn't compile against unpatched linux-next but it's 
> otherwise a reduced version of a series that went through review and 
> testing.
> 
> --
> Regards,
> Leonard
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
