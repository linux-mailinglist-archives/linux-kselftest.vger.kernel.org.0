Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700A67A2965
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Sep 2023 23:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236887AbjIOVbT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Sep 2023 17:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237601AbjIOVbN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Sep 2023 17:31:13 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE28B8;
        Fri, 15 Sep 2023 14:31:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ig8jVCPnvNpYlQJDPANaXGqg6oJXsDhztkk26aFzWhEQzJJl5Z9H9UrKQi5NQIskCeC9N93z40zaY8ly5dooTEnUO3Kj/MZbF5eel8kJBxxQb8oQu6IItpNffvXuBPJM5hK2SV5ZyByCvtm9rUjE1wECmKhCBn2uwXjrYQf64EM5h7HgkaL4p2J6xkP3Va8MZrqtbvwM8k5VdQ5c3QFbpgFU/oaTxDpfgAfYPy3mZe/u0kJF5WGOoCqH1w/lwXL72eMT8nl/8HzpoxeeqE9BAT05B5RqhF1YV6cVZUXF6H1DN3pVhzlXbHt3DpmTlLf/rVYxVeRqvr+u+2EuotISPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JoJuQTSLhyk51WMh4HDMA46YL23+jXLLlr4lbeC+UPc=;
 b=aCUsODOjd4R5BRturLkBC9kmM4U/SAqFtRxPuXmD4SJmFUxZvx/YEgCDIXrwIkaVaAN2kSho4nHmkJiQTSAtoCx0Dl9Cu39Mk2VbEpP8zVJbYft4EZk6SnkLEjlJdTvCNE6ROwj5Fzr9u86PR6bM+0SdEVkAOa31CbMcdoz8YiDebbGzd+U/5tt1QwoYnnapHe7qSfWZE7EleRrc3JzO9BhBdScjO/dXspmI32P7swIQaKP8+vCocu2Mb/vLTOToAWp7baat4BzZKSkoevuOda/1inPKm6aZXMkkZe73oRNFn1/mmiUgHjwBygWcbxnav1cdaWDw/ZA56p/6WWNzuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoJuQTSLhyk51WMh4HDMA46YL23+jXLLlr4lbeC+UPc=;
 b=mXeyZ9f7iH2g8o9OoDjd4hx8n+ij03+PWT79BsccqyEXkFHSQ5yTZDHN6+StlNRNW0uq16ZlJXfYC5F8P0lh17U1vB2T8djddAehZzG2tGCm6hOxWJ+KarsM0S6fHIYyv4HJzy03r+8YvubqK6e0CLYYPsvJa9S+289RKEno9xg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB6858.namprd12.prod.outlook.com (2603:10b6:510:1b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Fri, 15 Sep
 2023 21:31:04 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 21:31:04 +0000
Message-ID: <2fd025a9-52f3-4922-99cf-82355b0e35fe@amd.com>
Date:   Fri, 15 Sep 2023 16:31:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tools/power/x86/intel_pstate_tracer: Use pygnuplot
 package for Gnuplot
Content-Language: en-US
To:     Doug Smythies <dsmythies@telus.net>,
        'Swapnil Sapkal' <swapnil.sapkal@amd.com>,
        rafael.j.wysocki@intel.com, Ray.Huang@amd.com, li.meng@amd.com,
        shuah@kernel.org
Cc:     sukrut.bellary@gmail.com, gautham.shenoy@amd.com,
        wyes.karny@amd.com, Perry.Yuan@amd.com, zwisler@chromium.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>
References: <20230915104057.132210-1-swapnil.sapkal@amd.com>
 <20230915104057.132210-3-swapnil.sapkal@amd.com>
 <00b201d9e819$b2447e80$16cd7b80$@telus.net>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <00b201d9e819$b2447e80$16cd7b80$@telus.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB6858:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f7ed44b-2664-48cf-c309-08dbb63310a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vAz45FISJ3lQVuD4hvDbymDbg80107MVLRL5G1UVoWwH8jVN/tULo3OtDrawn0VTwUp0Fi0/AEO6W3GOQvQMt91ghtqrBR1QurZNkv+QlUU8rwIGEl+MMhZPlDGulJPkG5D0y873VlQOmLwWaMMbdP9iSAGKUI03QmHFu739T0Nsh/Yf5xd0H3QEdvb3cw7jDGndKaUwxEwSIXCRQ1zl3hEreIveXrN0vFFgheg9qb+rmOHq8r0j/WmOgkHy3u1hbEGf09/HKfRlSG8zibZoU5u5DMZUV1wz3922eWS/5sar/HnQONbog/ttw13+N4ybSkUNidrTm0afxgvfnN5HdxrGd8mo5T6yuEp+31ii2efDso3OOsWki8ES3nYYubG0AWaRAwdTlIeAsWd6+cu2j/raeahSZJ7O8frYohed1+fxpLF8YdxTL+4lbmv7eckBUneQR9e4YDiHOwN4OM0T5+bffDCx1N4lMGXbA0rLDRtB9aSqY/QHoiiLilLHWHzYBzn76PtAZvjyN4qlYF3H+RzUEGiu/kZwcJEeJV1D3H+jmtLxeVKNpQtklEOj/LimVsmfDPvsL3a+4sKZakibIbf3cswxk4+jkJBJ9jRiSZgTAwDfU66/s9oCA9rO+GKNoJQ5qbXmrsccEMKEjjhqIw9egTaJeW+88EHIe+DuwSc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(39860400002)(346002)(1800799009)(186009)(451199024)(66556008)(41300700001)(6506007)(316002)(966005)(110136005)(6666004)(6486002)(26005)(2616005)(66946007)(6512007)(53546011)(66476007)(478600001)(36756003)(8936002)(8676002)(2906002)(4326008)(86362001)(38100700002)(83380400001)(5660300002)(44832011)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q20xajJTbklUSVovSCs2WW5waE91K0tzNFl0U0xRU2t0US9lUjlmaDJJMkZ2?=
 =?utf-8?B?enZOYis4Z0prQ0NZSGxnNGtMTTU0c1B3RHZKS1lESzM1UWRDN1JWajdJdVI1?=
 =?utf-8?B?eEh0dVhFTmpyNG9nUWdSLzVlV1RWL3FuWDR1M3AvTml0aktNTnpLNmJpVzRC?=
 =?utf-8?B?KzNlWVZQU3YvVEZoN2VGUTh0dTBvSzFDUTBHOGFhRkhHSUhFU3Y0K0MzQktT?=
 =?utf-8?B?b05ZSjVPUGpJRTQvOE5JRTJvcjk1YUtMUThQbmR0REIrMEY4a2VWQ2ozK1ht?=
 =?utf-8?B?OUYvdWExR3F5LzRVRWYrSFlCSWJmbmdyQlpZTlRwTXNoS0E2eit4bWJBeDN5?=
 =?utf-8?B?NWVUYzVrN3JGSzZLaDFCRzk0QlVkaVJqcllIVDNxaVlybVAxWjNycnQ0VDI5?=
 =?utf-8?B?YXNJOGNOQXJUYkpFbmxGbU9lVkg5aldXL1dzak8wZDdRRitNdXozaGNsTUpV?=
 =?utf-8?B?N0V5eVdZQ21sRGFWbmdwL1Q1WUMyMHhUN00ySDUyOW9FZnNHZS8yamozNG4v?=
 =?utf-8?B?N01jbUo5VmRndFgvS1U4RmhMTWQ4MERVT0VlTnZ2bWRFcEtTMXo2Tm9KUzNS?=
 =?utf-8?B?bjdUdmwwZFBWejlxZ0JvME9icU4wMEpaUDA2eGJKbW1XZEpmSTBoSXFUWmF4?=
 =?utf-8?B?eTJ6Y3YzdWtOYVhEcWs3WTJacWNud04vV0tEWVZ5ei8yQUdJL0ViNTdHbHdo?=
 =?utf-8?B?b3d3WjRxU1NpY0NBamRPMDMxMXVVVjBZM0hXWGhIeFRYWDBOcjN5eUV3M3dz?=
 =?utf-8?B?Z1g2SWlzZVpndzZJckpCaHBXU2tZSnRyYnU4ZGN5OGxiUmY5UEw0SDFFTEpR?=
 =?utf-8?B?djZzb3N6VnZFaUZEODNwL2JyVzRXd1U4OWE0OUt0d2dkMkJpOWZmQ1haMjV1?=
 =?utf-8?B?NXE3aFhtZmhRZVVCZlFTQXAyODI4NXlWcWt5SXI3azBGL25jZGxGVzllTGhQ?=
 =?utf-8?B?SUJmSVUybE15RVd2RmlhU3lUcVpRZmloZ3RvNmVVeEVuR1UxWnc0c1JpUDFH?=
 =?utf-8?B?UFA3a0ZQU1ZpM0hybVdYdHJnUmF0ZzhMcVA0eGFFUG02ZGtDVTlpVkVzVE5M?=
 =?utf-8?B?bjV6U3d6cCthRGk5OHd2YjFadEEybXJMbkd3QWpmbGRxdHU1dHJEeEw5QjhV?=
 =?utf-8?B?akxPNFlhRnpFMzlsQUpoeFlwU1hQYWNQK0NSRFN5TTJqQ1BETndWWkJPbDJZ?=
 =?utf-8?B?K3ExTWJ3WnFCVVRXTXMxankwNTZ2UXByK0UzZTRzOGhHODU0OVNXQW5SdWtJ?=
 =?utf-8?B?ZnNQa3IrR1d4OW5POWFiQnlxWEthLzhGWlV5QzlDWDFXRkxjcER4cDQyUERK?=
 =?utf-8?B?YVE3NHlXVlhLNGF3RkhYZ09WSWg2MWs1U2U5eWoxVjl1Q2l0VHlyRTlqQmF1?=
 =?utf-8?B?eTQ2RHB6NGxKRXhraTdzUHl5czZaejZ6VFp1WnRaM2g5SE1GZXJNbWo1MU0y?=
 =?utf-8?B?V0g0MlFQMVowRFEyZ2JROUZ3Z3d5L0YyQmFwaDIyckxObXJrdDBhQkFyZ1RK?=
 =?utf-8?B?eXU0cVQ0Z1hHS1N0dS9EeUJDQTYzcGdmcWtVSjRucEthaWozNmQ5TTRVSkRs?=
 =?utf-8?B?UU9Hb3B0WVFEVXUvUHplS3dOaVg1Y1BzeEN5UXpWZWhSeVZXTTJRZlVNejBn?=
 =?utf-8?B?YVVUZFJDMGJVeFpnNituNmdvN0wvb2pPdnl2MTJSNnh0R1ZWMC90TXEzSDF3?=
 =?utf-8?B?d0oxVDkzQWF0NUdwYWJLZCtoTmthOVdDeXJMWHc5M0R3alpkUnpRNW9vSTh1?=
 =?utf-8?B?alJ3a2s4RXRyVU4rYkVRK3hlQmc1ekZzTEd4YVlFVnEveEtmNk9OMThjQXdh?=
 =?utf-8?B?aFNnbHF5ZjZpejlqeC8wRjNESG5zOVcra3F2aUU3ZXgxdy8yL1RrMXhJRjk3?=
 =?utf-8?B?TEhDWFJaTExtc3JxQURwMEEwcHc0NnNLVXJrUmtpU2pQNS85eFNEYWF6Lytv?=
 =?utf-8?B?VUhpVmhGcGoreHhkRTJJUDJPZWp4eU1IK1ljZStJVFJVazdGclNxOGQ4WHNy?=
 =?utf-8?B?eFFWUmhMbXB6dFFDcGIvODN6cHduNzB4aXlQd1Y2ZjhNUUxUMUEvc2w4Z2t6?=
 =?utf-8?B?eHI2R3hQcjNPZTR6bkVwTnJackxtV1BnbGw1L0xIUDV2OUJuTzFzcVd5azhK?=
 =?utf-8?Q?d0j31kyjqq+xmysaNDBD8EMdV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f7ed44b-2664-48cf-c309-08dbb63310a1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 21:31:04.3585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HGie57ro5j7gz+UTRUEQGjftupi2+8wjQ/ZN7SaMj5YXYR2bBJKdtwx3+DaAd9LYOG+m+rcsWk9iB5p72Ca+NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6858
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/15/2023 16:15, Doug Smythies wrote:
> On 2023.09.15 03:41 Swapnil Sapkal wrote:
> 
>> In intel_pstate_tracer.py, Gnuplot is used to generate 2D plots.
>> In current implementation this tracer gives error while importing
>> the module because Gnuplot is imported from package Gnuplot-py which
>> does not support python 3.x. Fix this by using pygnuplot package to
>> import this module.
> 
> As described in the prerequisites section, the package name is distribution dependant.
> On my distribution the original package name is phython3-gnuplot,
> and it is working fine.
> 
> sys.version_info(major=3, minor=8, micro=10, releaselevel='final', serial=0)
> 
> I don't currently have python3-pygnuplot installed, and so this patch breaks
> the  intel_pstate_tracer for me.
> 
> So, I installed the python3-pygnuplot package, and it still didn't work, as there
> still wasn't a pygnuplot module to import.
> So, I found something called PyGnuplot.py and so changed to that and got further.
> But then it got upset with:
> 
>    File "./intel_pstate_tracer.py.amd", line 298, in common_gnuplot_settings
>      g_plot = gnuplot.Gnuplot(persist=1)
> NameError: name 'gnuplot' is not defined
> 
> I gave up and returned to the unpatched
> intel_pstate_tracer.py
> And checked that is still worked fine. It did.
> 
> So, I do not accept this proposed patch.
> 
> Not really related, but for a few years now I have been meaning to
> change the minimum python version prerequisite to >= 3.0 and
> to change the shebang line from this:
> 
> #!/usr/bin/env python
> 
> To this:
> 
> #!/usr/bin/env python3
> 
> I have to use the latter version on my distro.
> Back when I looked into it, things were inconsistent,
> so I didn't know what to do. The kernel tree has 52 .py files
> of the latter shebang and 11 of the former.
> 
> ... Doug

Presumably this is the one that Swapnil intended:

https://pypi.org/project/py-gnuplot/

It requires python3, so I think if upgrading to this one the script does 
need to be switched to python3.  Besides the shebang, you should also 
use a helper like 2to3 to look for any other changes.

There were 97 hits for 'gnuplot' at pypi.  2 stood out but at least in 
the case of gnuplot based stuff, I think it's worth dropping
a comment that links back to pypi page for the intended package.

Another alternative is to include a 'requirements.txt' file that pip can 
pick up.

https://pip.pypa.io/en/stable/reference/requirements-file-format/


> 
>> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
>> ---
>> tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py      | 1 -
>> tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py | 4 ++--
>> 2 files changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py b/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
>> index 2448bb07973f..14f8d81f91de 100755
>> --- a/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
>> +++ b/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
>> @@ -27,7 +27,6 @@ import re
>>   import signal
>>   import sys
>>   import getopt
>> -import Gnuplot
>>   from numpy import *
>>   from decimal import *
>>   sys.path.append(os.path.join(os.path.dirname(__file__), '../intel_pstate_tracer'))
>> diff --git a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
>> index ec3323100e1a..68412abdd7d4 100755
>> --- a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
>> +++ b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
>> @@ -32,7 +32,7 @@ import re
>>   import signal
>>   import sys
>> import getopt
>> -import Gnuplot
>> +from pygnuplot import gnuplot
>>   from numpy import *
>>   from decimal import *
>>
>> @@ -295,7 +295,7 @@ def common_all_gnuplot_settings(output_png):
>> def common_gnuplot_settings():
>>       """ common gnuplot settings. """
>>
>> -    g_plot = Gnuplot.Gnuplot(persist=1)
>> +    g_plot = gnuplot.Gnuplot(persist=1)
>> #   The following line is for rigor only. It seems to be assumed for .csv files
>>       g_plot('set datafile separator \",\"')
>>       g_plot('set ytics nomirror')
>> -- 
>> 2.34.1
> 
> 

