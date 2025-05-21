Return-Path: <linux-kselftest+bounces-33463-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 173B0ABF628
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 15:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEC86163F95
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 13:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFA1270570;
	Wed, 21 May 2025 13:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JpQh4OKd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4560025DB0B;
	Wed, 21 May 2025 13:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747834390; cv=none; b=Bru2n4ujDgmV9DQGDu/kzhGLU18TxXkuUfhe7IXIU50RkUZ06SIQG3fk3f8skUsIVkiDbhAkdIfU5nsUO3fKgKaP+RPifVSKrvH0LPA9UVPeLhEIH5+puBEBVYMeScm+rNyD4SwkZztCvoGeccJ+ef9iWjQxKAP+KYkQA7tSgYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747834390; c=relaxed/simple;
	bh=klL2eYBoIcsBJjHpZtNu61Ygm4jyfn6fur4StJWIgXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M12QG8FY1CdqFbJder1RDokzBMgqJ0ZfXPxGcrACRxAStyd8mYCfhPSGseiI+nwJCT1Uba/L3XUkw0/RYpkrQvTTQBRa3eaMb7jTjeO1L5vz74zl6tgclVN0FPB76WviyegSZ3arSxLpmXZ/u0KvYi8ZYzZ1jf/NU7DAyCRWZcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JpQh4OKd; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747834388; x=1779370388;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=klL2eYBoIcsBJjHpZtNu61Ygm4jyfn6fur4StJWIgXk=;
  b=JpQh4OKdp9gt2zduCpPvLyy89yrCX2QS7JcJQ416azKujwkx+8wntA5p
   dFTIA7yM8ipUfjgztkew2EkRVd0Kok7NbWHj2IHYeTbmZhpyDHdYHwLaU
   OVvpCElLNbRmpUAx/NoxsrBfZm4wfxJss2q2J4QQd2fuaHXGvohBoqxVz
   rIFo3KnVkYJ3ILFziBjO4gHrV+lVHCZiGXHRS2kfRnUtg16erDpIedozR
   +lzGhEQP7hIx1yMkKcZHahEzAX7+hTpreRW3guuJ+EEBfVOvf7qBvZY45
   eyNog0rZZDZZYuMMX0mT/svs9zD9yTjI/8zb6tm3kjHtVG34UEwXoIh5/
   w==;
X-CSE-ConnectionGUID: V3XKuIPfTjikIAI44C/PGA==
X-CSE-MsgGUID: 5XM5VyReTOOk8ziRJIkIjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="61152255"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="61152255"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 06:33:07 -0700
X-CSE-ConnectionGUID: gQ2NzB9HRz6+jLshfF0ytA==
X-CSE-MsgGUID: AgV4E0nlSXCOSrp/0vhlxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="139926016"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 21 May 2025 06:33:03 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uHjZ7-000OJC-0y;
	Wed, 21 May 2025 13:33:01 +0000
Date: Wed, 21 May 2025 21:32:03 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Waiman Long <longman@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-api@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Subject: Re: [PATCH v4 3/7] futex: Use explicit sizes for
 compat_exit_robust_list
Message-ID: <202505212147.5qoTgcmU-lkp@intel.com>
References: <20250520-tonyk-robust_futex-v4-3-1123093e59de@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250520-tonyk-robust_futex-v4-3-1123093e59de@igalia.com>

Hi André,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 3ee84e3dd88e39b55b534e17a7b9a181f1d46809]

url:    https://github.com/intel-lab-lkp/linux/commits/Andr-Almeida/selftests-futex-Add-ASSERT_-macros/20250521-045231
base:   3ee84e3dd88e39b55b534e17a7b9a181f1d46809
patch link:    https://lore.kernel.org/r/20250520-tonyk-robust_futex-v4-3-1123093e59de%40igalia.com
patch subject: [PATCH v4 3/7] futex: Use explicit sizes for compat_exit_robust_list
config: arm-randconfig-002-20250521 (https://download.01.org/0day-ci/archive/20250521/202505212147.5qoTgcmU-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project f819f46284f2a79790038e1f6649172789734ae8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250521/202505212147.5qoTgcmU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505212147.5qoTgcmU-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from io_uring/notif.c:9:
   In file included from io_uring/notif.h:5:
   In file included from include/net/sock.h:46:
   In file included from include/linux/netdevice.h:44:
   In file included from include/uapi/linux/neighbour.h:6:
   In file included from include/linux/netlink.h:9:
   In file included from include/net/scm.h:13:
   In file included from include/net/compat.h:8:
>> include/linux/compat.h:665:35: warning: declaration of 'struct robust_list_head32' will not be visible outside of this function [-Wvisibility]
     665 | compat_sys_set_robust_list(struct robust_list_head32 __user *head,
         |                                   ^
   1 warning generated.
--
   In file included from io_uring/uring_cmd.c:9:
   In file included from include/net/sock.h:46:
   In file included from include/linux/netdevice.h:44:
   In file included from include/uapi/linux/neighbour.h:6:
   In file included from include/linux/netlink.h:9:
   In file included from include/net/scm.h:13:
   In file included from include/net/compat.h:8:
>> include/linux/compat.h:665:35: warning: declaration of 'struct robust_list_head32' will not be visible outside of this function [-Wvisibility]
     665 | compat_sys_set_robust_list(struct robust_list_head32 __user *head,
         |                                   ^
   io_uring/uring_cmd.c:311:19: warning: unused function 'io_uring_cmd_getsockopt' [-Wunused-function]
     311 | static inline int io_uring_cmd_getsockopt(struct socket *sock,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~
   io_uring/uring_cmd.c:338:19: warning: unused function 'io_uring_cmd_setsockopt' [-Wunused-function]
     338 | static inline int io_uring_cmd_setsockopt(struct socket *sock,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~
   3 warnings generated.


vim +665 include/linux/compat.h

   621	
   622	#ifdef __ARCH_WANT_COMPAT_SYS_PWRITEV64
   623	asmlinkage long compat_sys_pwritev64(unsigned long fd,
   624			const struct iovec __user *vec,
   625			unsigned long vlen, loff_t pos);
   626	#endif
   627	asmlinkage long compat_sys_sendfile(int out_fd, int in_fd,
   628					    compat_off_t __user *offset, compat_size_t count);
   629	asmlinkage long compat_sys_sendfile64(int out_fd, int in_fd,
   630					    compat_loff_t __user *offset, compat_size_t count);
   631	asmlinkage long compat_sys_pselect6_time32(int n, compat_ulong_t __user *inp,
   632					    compat_ulong_t __user *outp,
   633					    compat_ulong_t __user *exp,
   634					    struct old_timespec32 __user *tsp,
   635					    void __user *sig);
   636	asmlinkage long compat_sys_pselect6_time64(int n, compat_ulong_t __user *inp,
   637					    compat_ulong_t __user *outp,
   638					    compat_ulong_t __user *exp,
   639					    struct __kernel_timespec __user *tsp,
   640					    void __user *sig);
   641	asmlinkage long compat_sys_ppoll_time32(struct pollfd __user *ufds,
   642					 unsigned int nfds,
   643					 struct old_timespec32 __user *tsp,
   644					 const compat_sigset_t __user *sigmask,
   645					 compat_size_t sigsetsize);
   646	asmlinkage long compat_sys_ppoll_time64(struct pollfd __user *ufds,
   647					 unsigned int nfds,
   648					 struct __kernel_timespec __user *tsp,
   649					 const compat_sigset_t __user *sigmask,
   650					 compat_size_t sigsetsize);
   651	asmlinkage long compat_sys_signalfd4(int ufd,
   652					     const compat_sigset_t __user *sigmask,
   653					     compat_size_t sigsetsize, int flags);
   654	asmlinkage long compat_sys_newfstatat(unsigned int dfd,
   655					      const char __user *filename,
   656					      struct compat_stat __user *statbuf,
   657					      int flag);
   658	asmlinkage long compat_sys_newfstat(unsigned int fd,
   659					    struct compat_stat __user *statbuf);
   660	/* No generic prototype for sync_file_range and sync_file_range2 */
   661	asmlinkage long compat_sys_waitid(int, compat_pid_t,
   662			struct compat_siginfo __user *, int,
   663			struct compat_rusage __user *);
   664	asmlinkage long
 > 665	compat_sys_set_robust_list(struct robust_list_head32 __user *head,
   666				   compat_size_t len);
   667	asmlinkage long
   668	compat_sys_get_robust_list(int pid, compat_uptr_t __user *head_ptr,
   669				   compat_size_t __user *len_ptr);
   670	asmlinkage long compat_sys_getitimer(int which,
   671					     struct old_itimerval32 __user *it);
   672	asmlinkage long compat_sys_setitimer(int which,
   673					     struct old_itimerval32 __user *in,
   674					     struct old_itimerval32 __user *out);
   675	asmlinkage long compat_sys_kexec_load(compat_ulong_t entry,
   676					      compat_ulong_t nr_segments,
   677					      struct compat_kexec_segment __user *,
   678					      compat_ulong_t flags);
   679	asmlinkage long compat_sys_timer_create(clockid_t which_clock,
   680				struct compat_sigevent __user *timer_event_spec,
   681				timer_t __user *created_timer_id);
   682	asmlinkage long compat_sys_ptrace(compat_long_t request, compat_long_t pid,
   683					  compat_long_t addr, compat_long_t data);
   684	asmlinkage long compat_sys_sched_setaffinity(compat_pid_t pid,
   685					     unsigned int len,
   686					     compat_ulong_t __user *user_mask_ptr);
   687	asmlinkage long compat_sys_sched_getaffinity(compat_pid_t pid,
   688					     unsigned int len,
   689					     compat_ulong_t __user *user_mask_ptr);
   690	asmlinkage long compat_sys_sigaltstack(const compat_stack_t __user *uss_ptr,
   691					       compat_stack_t __user *uoss_ptr);
   692	asmlinkage long compat_sys_rt_sigsuspend(compat_sigset_t __user *unewset,
   693						 compat_size_t sigsetsize);
   694	#ifndef CONFIG_ODD_RT_SIGACTION
   695	asmlinkage long compat_sys_rt_sigaction(int,
   696					 const struct compat_sigaction __user *,
   697					 struct compat_sigaction __user *,
   698					 compat_size_t);
   699	#endif
   700	asmlinkage long compat_sys_rt_sigprocmask(int how, compat_sigset_t __user *set,
   701						  compat_sigset_t __user *oset,
   702						  compat_size_t sigsetsize);
   703	asmlinkage long compat_sys_rt_sigpending(compat_sigset_t __user *uset,
   704						 compat_size_t sigsetsize);
   705	asmlinkage long compat_sys_rt_sigtimedwait_time32(compat_sigset_t __user *uthese,
   706			struct compat_siginfo __user *uinfo,
   707			struct old_timespec32 __user *uts, compat_size_t sigsetsize);
   708	asmlinkage long compat_sys_rt_sigtimedwait_time64(compat_sigset_t __user *uthese,
   709			struct compat_siginfo __user *uinfo,
   710			struct __kernel_timespec __user *uts, compat_size_t sigsetsize);
   711	asmlinkage long compat_sys_rt_sigqueueinfo(compat_pid_t pid, int sig,
   712					struct compat_siginfo __user *uinfo);
   713	/* No generic prototype for rt_sigreturn */
   714	asmlinkage long compat_sys_times(struct compat_tms __user *tbuf);
   715	asmlinkage long compat_sys_getrlimit(unsigned int resource,
   716					     struct compat_rlimit __user *rlim);
   717	asmlinkage long compat_sys_setrlimit(unsigned int resource,
   718					     struct compat_rlimit __user *rlim);
   719	asmlinkage long compat_sys_getrusage(int who, struct compat_rusage __user *ru);
   720	asmlinkage long compat_sys_gettimeofday(struct old_timeval32 __user *tv,
   721			struct timezone __user *tz);
   722	asmlinkage long compat_sys_settimeofday(struct old_timeval32 __user *tv,
   723			struct timezone __user *tz);
   724	asmlinkage long compat_sys_sysinfo(struct compat_sysinfo __user *info);
   725	asmlinkage long compat_sys_mq_open(const char __user *u_name,
   726				int oflag, compat_mode_t mode,
   727				struct compat_mq_attr __user *u_attr);
   728	asmlinkage long compat_sys_mq_notify(mqd_t mqdes,
   729				const struct compat_sigevent __user *u_notification);
   730	asmlinkage long compat_sys_mq_getsetattr(mqd_t mqdes,
   731				const struct compat_mq_attr __user *u_mqstat,
   732				struct compat_mq_attr __user *u_omqstat);
   733	asmlinkage long compat_sys_msgctl(int first, int second, void __user *uptr);
   734	asmlinkage long compat_sys_msgrcv(int msqid, compat_uptr_t msgp,
   735			compat_ssize_t msgsz, compat_long_t msgtyp, int msgflg);
   736	asmlinkage long compat_sys_msgsnd(int msqid, compat_uptr_t msgp,
   737			compat_ssize_t msgsz, int msgflg);
   738	asmlinkage long compat_sys_semctl(int semid, int semnum, int cmd, int arg);
   739	asmlinkage long compat_sys_shmctl(int first, int second, void __user *uptr);
   740	asmlinkage long compat_sys_shmat(int shmid, compat_uptr_t shmaddr, int shmflg);
   741	asmlinkage long compat_sys_recvfrom(int fd, void __user *buf, compat_size_t len,
   742				    unsigned flags, struct sockaddr __user *addr,
   743				    int __user *addrlen);
   744	asmlinkage long compat_sys_sendmsg(int fd, struct compat_msghdr __user *msg,
   745					   unsigned flags);
   746	asmlinkage long compat_sys_recvmsg(int fd, struct compat_msghdr __user *msg,
   747					   unsigned int flags);
   748	/* No generic prototype for readahead */
   749	asmlinkage long compat_sys_keyctl(u32 option,
   750				      u32 arg2, u32 arg3, u32 arg4, u32 arg5);
   751	asmlinkage long compat_sys_execve(const char __user *filename, const compat_uptr_t __user *argv,
   752			     const compat_uptr_t __user *envp);
   753	/* No generic prototype for fadvise64_64 */
   754	/* CONFIG_MMU only */
   755	asmlinkage long compat_sys_rt_tgsigqueueinfo(compat_pid_t tgid,
   756						compat_pid_t pid, int sig,
   757						struct compat_siginfo __user *uinfo);
   758	asmlinkage long compat_sys_recvmmsg_time64(int fd, struct compat_mmsghdr __user *mmsg,
   759					    unsigned vlen, unsigned int flags,
   760					    struct __kernel_timespec __user *timeout);
   761	asmlinkage long compat_sys_recvmmsg_time32(int fd, struct compat_mmsghdr __user *mmsg,
   762					    unsigned vlen, unsigned int flags,
   763					    struct old_timespec32 __user *timeout);
   764	asmlinkage long compat_sys_wait4(compat_pid_t pid,
   765					 compat_uint_t __user *stat_addr, int options,
   766					 struct compat_rusage __user *ru);
   767	asmlinkage long compat_sys_fanotify_mark(int, unsigned int, __u32, __u32,
   768						    int, const char __user *);
   769	asmlinkage long compat_sys_open_by_handle_at(int mountdirfd,
   770						     struct file_handle __user *handle,
   771						     int flags);
   772	asmlinkage long compat_sys_sendmmsg(int fd, struct compat_mmsghdr __user *mmsg,
   773					    unsigned vlen, unsigned int flags);
   774	asmlinkage long compat_sys_execveat(int dfd, const char __user *filename,
   775			     const compat_uptr_t __user *argv,
   776			     const compat_uptr_t __user *envp, int flags);
   777	asmlinkage ssize_t compat_sys_preadv2(compat_ulong_t fd,
   778			const struct iovec __user *vec,
   779			compat_ulong_t vlen, u32 pos_low, u32 pos_high, rwf_t flags);
   780	asmlinkage ssize_t compat_sys_pwritev2(compat_ulong_t fd,
   781			const struct iovec __user *vec,
   782			compat_ulong_t vlen, u32 pos_low, u32 pos_high, rwf_t flags);
   783	#ifdef __ARCH_WANT_COMPAT_SYS_PREADV64V2
   784	asmlinkage long  compat_sys_preadv64v2(unsigned long fd,
   785			const struct iovec __user *vec,
   786			unsigned long vlen, loff_t pos, rwf_t flags);
   787	#endif
   788	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

