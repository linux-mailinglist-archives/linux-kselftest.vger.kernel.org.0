Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC6164259C
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Dec 2022 10:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiLEJTV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Dec 2022 04:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiLEJTH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Dec 2022 04:19:07 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42ADC178A7;
        Mon,  5 Dec 2022 01:18:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxDc/4CCu0ALtGrrqfwA/4e4/nzqOJKcxamw8xXuLs8L+S/75pRc31x2ZmkdaVhug/CCTn5th7wNYkKaBGIB7U1lUUuifoZLeQg5490qrBRkjrDNZz0osog/2hlLCXnBle79vcKoBpxB3qa8eS7LiBLJwxXQdVjouvlkExvZ+/I2f64+nXWcXznBbtJ2MxsdC1iSSAsf2ipLuZshnOfSlo7gBBzl0LHQXHjuObdBSj7ODr3XLvCaDxJa/3j0Hg90Ao4EJBZENkvZbjU1Hu6RwVoXFHKPyTzSZwWFKCAFSbhHS3cCnx5jUJPVuOm3gEnOVSM3eeSgY6o9fYEl63lsrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GF1/mF7NRbXov2SGSyl/nAfzn0VO+yBAIikJXvvTUuU=;
 b=JVIiTQ369UKMMkVkWTgoWslKAgBHPSK7TOfqBhXU7AzOEFeAncpA54VivFl2ztl/4JKvRz945OgLDiQXhmBOEExyCW+OcRAX7IyG40UZiQSJH/4FUfWw3t/wbIP6qgnEefbMVSLBuLlPadqdK2zeZElPWxo9hpDQ2Kb4jatfcSxxU9AY9mgw4Eo4Vu/SfDupRkEGak3nVirXDml1OiSiPjUnQwXk4sqLE6LNCW3Q/bCUpfYBVK9zIRfMpIeVdipyd0vATXM7qCgMBUTqnybO+lVFXdcjvQ6QORrdmBc65VY31MiIv/2rt16KlUgtve8BScmP7AX4sV+CnJzOciTBJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GF1/mF7NRbXov2SGSyl/nAfzn0VO+yBAIikJXvvTUuU=;
 b=ZMGYziJBaNFoAQb8srYp/wwPgI8TK/U/Cp+Q9JA4vDa2FoZdOYpBmnnDm9C7jiOlsHZU1ZK/LsdOhEG4bJBZQdLkkvRxVwpPJPBb8ruqbGaGOdr4ZKZKb6ZVABPbKudNPfom+LTMXuKUo76ovIFXKEXpJPWjMus7BZNrtZCgmq4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 IA0PR12MB8351.namprd12.prod.outlook.com (2603:10b6:208:40e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.13; Mon, 5 Dec 2022 09:18:49 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::2443:424:1c7c:17cc%6]) with mapi id 15.20.5857.023; Mon, 5 Dec 2022
 09:18:49 +0000
Date:   Mon, 5 Dec 2022 17:18:24 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Meng, Li (Jassmine)" <Li.Meng@amd.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH V2 2/2] Documentation: amd-pstate: Add speedometer
 test introduction
Message-ID: <Y423YIb8bxIe5xY8@amd.com>
References: <20221107011127.1818705-1-li.meng@amd.com>
 <20221107011127.1818705-3-li.meng@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107011127.1818705-3-li.meng@amd.com>
X-ClientProxiedBy: SI2PR01CA0026.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::16) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|IA0PR12MB8351:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ea897e9-9448-41c3-2e36-08dad6a1b7c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2KeAPYfZSXkjOg4mq+mTAnWtDvLOmv5ZLE2hSXFhF8ZdtXe2rDuRnPQa8HlEcp9pvPHOXckSoEuCELXHJ9FF/pVdQZ2TRTgSX/Zfdp1WpoCSUIiCpxmsNWc4t7jZBBouVmGfE2AdZWEik71JKhdvJeJQm6p/rCz9HY7E2ZtgEAsmQZ+7YRj8yPF0rjGmuoGhR515h9JZgvbpXvhGsiQxUR25suRPqFkhjqK1XGwhp6LpAdMM3seBsjSmyVfRbtCEWDYqsoV9OJkzXevcFwyEPDuXDKAn8o+Dkaextt9J9Is4uUF9DeJhcFEW7dyGTYrPqP3EZAgVK8c++CF3Sb11bblhwOdnc90R+Mukf9Nu28CNcj3eNsJJyxvOheWH3BZyrLuQFPRpcynlrsyQWKT1dD65AgS7s0KVgZUkVlzPn2zvml9UPImC8O4n5WzhEysLxHPDjHO1aZ24r+r+2KKqxV/Kbp18LSRJ6dnZSjVU9pnGiupe9SIbG1fThsMqfqA+TjjKsAwJRMww9G4IZ1bs4/aLEVwCyKpb8QUbek2TXyOpyvU0kiRVTz9HHX6uHqz5VE6pjv1aNcgDz8XugElyd3F10nWP/OBgQfeU3APWy1ua8i2+4MTFeVQ/cq1UKnVjz83pVC2FC7kI/fWiIp40LQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(451199015)(83380400001)(86362001)(38100700002)(6862004)(41300700001)(4326008)(5660300002)(8936002)(2906002)(66946007)(8676002)(6512007)(6506007)(26005)(66574015)(6666004)(186003)(316002)(66556008)(37006003)(6636002)(54906003)(66476007)(6486002)(478600001)(2616005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h5tcHRaBqmMBoeg31cFft7pl8aOyoiIuW0pb3Jpr/WLlOx2kPfUdCv5fOoGf?=
 =?us-ascii?Q?NmP4vAgouRNHjwShsk//9HhZJGCqWcCV21Vmsy6WktylYyfVPMHjmcQ13pG0?=
 =?us-ascii?Q?weeH/EVOF0GxELM1zFYCkrvu5xuZoTvsFWNnPsRc50W+gLzrVCRlJVJTxC+L?=
 =?us-ascii?Q?hl+dQvV3J+23pB7ddU6JkVHfF2H0DDHIPA7eTCh7TD4Mi51uzS/jA7IJ2rxZ?=
 =?us-ascii?Q?HHlWcpsn7lTwEFI25b0brlxs4CHTzRTpBDeMh/XHmaQN8F8TJCcLeE9sJTSs?=
 =?us-ascii?Q?1pm35uoYZAE2FHUExOmPP83wmLsNpXa7vTTSvhVfwVizyOEoJAKOP8lCWvoR?=
 =?us-ascii?Q?APKwKxqdVVL6i2+fhMp99ZYDmwj7QALyWGjArxP2XhtG5k15dpsJ6EdLviqM?=
 =?us-ascii?Q?K3RmCKTccLR0Cr0cHF5e5yMA9a2s+/7XDZD6A2O6pVdoy+6+yg6K6E2EV4M5?=
 =?us-ascii?Q?0HBCRFCzoJWip+1OvAN6xFI3fwHRLkN+rdKWCd52qIu3mQN6HXZXuSrAYLuI?=
 =?us-ascii?Q?wCU1N7TP1B7FPipleP8Es9Xs0AJPVYhMc3Bo+gqZOcmzBcIQP0tdhR/OijzS?=
 =?us-ascii?Q?zsUdjQ5XU/6fbLxeyYwF3FhWV4OMU6nO+l0z4YyqEO7pQ6/xHJfPmMSG6vsZ?=
 =?us-ascii?Q?1Q2sjQXleSLP/h4lFEu23P1uweuFqzhqjwo5TVhKg5Zg1IvMBgJ7A0EdB0cJ?=
 =?us-ascii?Q?D8BhfrDteYzEwonBI/WNfzR5VlSzapKLJmJWmFYEGXv+CMaRVFoGLl/NKPyX?=
 =?us-ascii?Q?uYhSNyt48HzQMD+IJ8j5SMwMGdtWKdnC0pnDL2RW3s8r8UHaMol4SdDnfKhD?=
 =?us-ascii?Q?65cAWsmQBUmH15Qv7n/h102hjNzL77dxP8kf5xRQh0oPmKp40MrTYUqSr0hg?=
 =?us-ascii?Q?+Mv1ChDBqP1v+mgbPqcJAhJQvZqPcMGKVrW8Xh7zrmqQwLuWSnnW2Sha8GPv?=
 =?us-ascii?Q?Ye4zlnWepiOHjsNEv0CujI2RZHSQvHTnK22mpsfzOVypQj7Vz4ZA4s3f3yCg?=
 =?us-ascii?Q?ke8yTlndB7fhPhBRUz5HIr0p7Irkdwqyn423fvhg+Mae9k7PT+uNB1cybAyL?=
 =?us-ascii?Q?Joz7bi0YcVbjJ9JH8NddwWI5Du/2/XBz8g45+0tE89TjH8PeqJOJgCSaV3Wa?=
 =?us-ascii?Q?dBwDxPrRikW6HP7wL/p9azQDzXABfUZcNRnxGfSKRP2jiUYh78dn2hNp/lmG?=
 =?us-ascii?Q?EgYztq4d6z1AodIs1Ku7PsRyDnExlP8zxa8meUQUSgGj55cVgqJ+fY7kDhU7?=
 =?us-ascii?Q?bhyrjOibISf++02RmllPh1301yyPtKjBE4CyMqI0fFmIx/gmLj+seN4rm+p1?=
 =?us-ascii?Q?FNfWA7gBsv+v/6xq31zpNohv0uI2TIYBznNJ/EKQAZQ6M+Z5QkgrrN6hGuhJ?=
 =?us-ascii?Q?xsmsy3kFdG0Q68+H6Vr97UWX6sWhKdi9/wYPLq31s9PLD7/w4S/RoSVT+f1G?=
 =?us-ascii?Q?zBftKWu3or39MXW9yzmzbwcwIeVUYhJ+ZTz3pcDtbi9xADEl/ciwXmZnR6TE?=
 =?us-ascii?Q?iOc6JKSeY/YFeyvGQa3/hlDzSkCDPjPCBhKfzKi2zG2iA0NCxoGO8hMAT80M?=
 =?us-ascii?Q?xCaTWou5ojfO/XrjsY5b1T7MS6tKdDBQQkI48BFB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea897e9-9448-41c3-2e36-08dad6a1b7c8
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 09:18:48.9024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nuI5NS4MbP6CIUEOpv+nQwAsyJeGy2IBFJuboqWtwjwnck4mB42Y5KWJTm5Wv38At6Xdlkmrv9R/MZ2wlpRYnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8351
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 07, 2022 at 09:11:27AM +0800, Meng, Li (Jassmine) wrote:
> Introduce speedometer test cases design and implementation.
> Monitor cpus changes about performance and power consumption etc.
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> ---
>  Documentation/admin-guide/pm/amd-pstate.rst | 75 ++++++++++++++++++++-
>  1 file changed, 74 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 29c50e96eb95..0163d1231aa7 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -451,6 +451,23 @@ Unit Tests for amd-pstate
>          The specified governor is ondemand or schedutil.
>          Gitsource can also be tested on the ``acpi-cpufreq`` kernel driver for comparison.
>  
> +    4). Speedometer test
> +
> +        Test and monitor the cpu changes when running speedometer benchmark under the specified governor.
> +        These changes include desire performance, frequency, load, time, energy etc.
> +        The specified governor is ondemand or schedutil.
> +        Speedometer can also be tested on the ``acpi-cpufreq`` kernel driver for comparison.
> +
> +#. Preparations before tests
> +
> +    1). Speedometer
> +
> +     + Python version 3.0.x or higher
> +     + Install chromium-browser
> +     + Install chromium-chromedriver
> +     + Install selenium on the client
> +     + Install selenium-server on the server
> +
>  #. How to execute the tests
>  
>     We use test module in the kselftest frameworks to implement it.
> @@ -487,6 +504,8 @@ Unit Tests for amd-pstate
>          $ sudo ./run.sh -t tbench -m acpi-cpufreq
>          $ sudo ./run.sh -t gitsource
>          $ sudo ./run.sh -t gitsource -m acpi-cpufreq
> +        $ sudo ./run.sh -t speedometer
> +        $ sudo ./run.sh -t speedometer -m acpi-cpufreq

While I run the above scripts: sudo ./run.sh -t speedometer

I found Tbench test result will be reported as well, but it reported as a
runtime error.

Tbench test result for ondemand (loops:3)
--------------------------------------------------
Tbench-ondemand avg des perf: -nan
Tbench-ondemand avg freq: -nan
Tbench-ondemand avg load: -nan
Tbench-ondemand total throughput(MB/s): 0
Tbench-ondemand avg throughput(MB/s): 0
Tbench-ondemand total power consumption(J): 0
Tbench-ondemand avg power consumption(J): 0
Runtime error (func=(main), adr=14): Divide by zero
Tbench-ondemand performance per watt(MB/J):

I think we may have more detailed steps to tell every one how to execute the tests easily.

Thanks,
Ray

>          $ ./run.sh --help
>          ./run.sh: illegal option -- -
>          Usage: ./run.sh [OPTION...]
> @@ -495,7 +514,8 @@ Unit Tests for amd-pstate
>                  [-c <all: All testing,
>                       basic: Basic testing,
>                       tbench: Tbench testing,
> -                     gitsource: Gitsource testing.>]
> +                     gitsource: Gitsource testing,
> +                     speedometer: Speedometer testing.>]
>                  [-t <tbench time limit>]
>                  [-p <tbench process number>]
>                  [-l <loop times for tbench>]
> @@ -621,6 +641,59 @@ Unit Tests for amd-pstate
>           + acpi-cpufreq-schedutil VS amd-pstate-schedutil  | Comprison(%) |          |          |          | 2.1115      | 4.2873  | -4.1110              |
>           +-------------------------------------------------+--------------+----------+----------+----------+-------------+---------+----------------------+
>  
> +        + speedometer
> +
> +         When you finish test, you will get selftest.speedometer.csv and png images.
> +         The selftest.speedometer.csv file contains the raw data and the drop of the comparative test.
> +         The png images shows the goal, time, energy and performan per watt of each test.
> +         Open selftest.speedometer.csv :
> +
> +         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
> +         + Governor                                        | Round        | Des-perf | Freq     | Load     | Goal        | Time        | Energy  | Performance Per Watt |
> +         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
> +         + Unit                                            |              |          | GHz      |          | Runs/Minute | s           | J       | Runs/w               |
> +         +=================================================+==============+==========+==========+==========+=============+=============+=========+======================+
> +         + acpi-cpufreq-ondemand                           | 1            |          |          |          | 209         | 51          | 731.84  | 0.2427               |
> +         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
> +         + acpi-cpufreq-ondemand                           | 2            |          |          |          | 205         | 51          | 759.03  | 0.2295               |
> +         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
> +         + acpi-cpufreq-ondemand                           | 3            |          |          |          | 206         | 51          | 755.15  | 0.2318               |
> +         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
> +         + acpi-cpufreq-ondemand                           | Average      |          |          |          | 206.667     | 51          | 748.673 | 0.2346               |
> +         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
> +         + acpi-cpufreq-schedutil                          | 1            |          |          |          | 206         | 56          | 775.08  | 0.248                |
> +         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
> +         + acpi-cpufreq-schedutil                          | 2            |          |          |          | 204         | 51          | 762.06  | 0.2275               |
> +         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
> +         + acpi-cpufreq-schedutil                          | 3            |          |          |          | 207         | 56          | 776.35  | 0.2488               |
> +         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
> +         + acpi-cpufreq-schedutil                          | Average      |          |          |          | 205.667     | 54.3333     | 771.163 | 0.2415               |
> +         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
> +         + amd-pstate-ondemand                             | 1            | 24.7974  | 1.73142  | 7.71728  | 195         | 64          | 756.6   | 0.2749               |
> +         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
> +         + amd-pstate-ondemand                             | 2            | 26.1653  | 1.91492  | 8.5525   | 195         | 51          | 705.67  | 0.2348               |
> +         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
> +         + amd-pstate-ondemand                             | 3            | 24.1789  | 1.69516  | 7.41152  | 196         | 65          | 758.98  | 0.2797               |
> +         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
> +         + amd-pstate-ondemand                             | Average      | 25.0472  | 1.7805   | 7.89377  | 195.333     | 60          | 740.417 | 0.2638               |
> +         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
> +         + amd-pstate-schedutil                            | 1            | 67.0214  | 2.76691  | 17.1314  | 197         | 51          | 737.52  | 0.227                |
> +         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
> +         + amd-pstate-schedutil                            | 2            | 64.3032  | 2.75981  | 16.1196  | 198         | 55          | 763.57  | 0.2376               |
> +         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
> +         + amd-pstate-schedutil                            | 3            | 65.5175  | 2.59423  | 17.0067  | 201         | 51          | 735.96  | 0.2321               |
> +         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
> +         + amd-pstate-schedutil                            | Average      | 65.614   | 2.70698  | 16.7526  | 198.667     | 52.3333     | 745.683 | 0.2323               |
> +         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
> +         + acpi-cpufreq-ondemand VS acpi-cpufreq-schedutil | Comprison(%) |          |          |          | -0.4838     | 6.5358      | 3.0039  | 2.9411               |
> +         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
> +         + amd-pstate-ondemand VS amd-pstate-schedutil     | Comprison(%) | 161.9614 | 52.0348  | 112.2255 | 1.7068      | -12.7778    | 0.7112  | -11.9408             |
> +         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
> +         + acpi-cpufreq-ondemand VS amd-pstate-ondemand    | Comprison(%) |          |          |          | -5.4841     | 17.647      | -1.1027 | 12.4467              |
> +         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
> +         + acpi-cpufreq-schedutil VS amd-pstate-schedutil  | Comprison(%) |          |          |          | -3.4035     | -3.6809     | -3.3041 | -3.8095              |
> +         +-------------------------------------------------+--------------+----------+----------+----------+-------------+-------------+---------+----------------------+
> +
>  Reference
>  ===========
>  
> -- 
> 2.34.1
> 
